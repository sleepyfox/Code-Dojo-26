should = require('chai').should()

describe 'A Work item', ->
  SUCCESSFUL_TRANSITION = true
  TRANSITION_FAILED = false

  exampleWorkflow =
    initialState: 'New permit'
    transitions:
      'New permit': 
        'submit': 'Submitted permit'
      'Submitted permit':
        'approve': 'Approved permit'
        'reject': 'Rejected permit'
      'Approved permit': {}
      'Rejected permit': {}

  class WorkItem
    constructor: (@workflow) ->
      @state = @workflow.initialState

    transition: (action) ->
      if @workflow.transitions?[@state]?.hasOwnProperty(action) 
        @state = @workflow.transitions?[@state]?[action]
        return this
      else 
        TRANSITION_FAILED

    getState: ->
      @state

  workItemFactory = (state) -> 
    states = 
      'created': (item) ->
        item # identity fn
      'submitted': (item) -> 
        item.transition('submit') or TRANSITION_FAILED 
      'approved': (item) -> 
        item.transition('submit').transition('approve') or TRANSITION_FAILED
      'rejected': (item) -> 
        item.transition('submit').transition('reject') or TRANSITION_FAILED
    myItem = new WorkItem exampleWorkflow
    states[state](myItem)
    
  it 'should when created have an initial state "New permit"', ->
    myWorkItem = workItemFactory('created')
    myWorkItem.getState().should.equal 'New permit'

  it 'should when submitted have a state "Submitted permit"', ->
    myWorkItem = workItemFactory('submitted')
    myWorkItem.getState().should.equal 'Submitted permit'

  it 'should when approved have a state "Approved permit"', ->
    myWorkItem = workItemFactory('approved')
    myWorkItem.getState().should.equal 'Approved permit'

  it 'should when rejected have state "Rejected permit"', ->
    myWorkItem = workItemFactory('rejected')
    myWorkItem.getState().should.equal 'Rejected permit'

  it 'should not be able to approve from initial state', ->
    myWorkItem = workItemFactory('created')
    myWorkItem.transition('approve').should.equal TRANSITION_FAILED
    myWorkItem.getState().should.equal 'New permit'

  it 'should not be able to reject from initial state', ->
    myWorkItem = workItemFactory('created')
    myWorkItem.transition('reject').should.equal TRANSITION_FAILED
    myWorkItem.getState().should.equal 'New permit'

  it 'should not be able to submit from a rejected state', ->
    myWorkItem = workItemFactory('rejected')
    myWorkItem.transition('submit').should.equal TRANSITION_FAILED

  it 'should not be able to submit from an approved state', ->
    myWorkItem = workItemFactory('approved')
    myWorkItem.transition('submit').should.equal TRANSITION_FAILED

  it 'should not allow a spurious transition', ->
    myWorkItem = workItemFactory('created')
    myWorkItem.transition('fubar').should.equal TRANSITION_FAILED

  it 'a factory supplied submitted item should have state "Submitted permit"', ->
    workItemFactory('submitted').getState().should.equal 'Submitted permit'

  it 'a factory supplied submitted item should have state "Approved permit"', ->
    workItemFactory('approved').getState().should.equal 'Approved permit'

  it 'a factory supplied submitted item should have state "Rejected permit"', ->
    workItemFactory('rejected').getState().should.equal 'Rejected permit'

