should = require('chai').should()

describe 'A Work item', ->
  SUCCESSFUL_TRANSITION = true
  TRANSITION_FAILED = false
  INITIAL_STATE = 'New permit'
  
  class WorkItem
    constructor: ->
      @state = INITIAL_STATE
    transition: (action) ->
      allowed_transitions = 
        'New permit': 
          'submit': 'Submitted permit'
        'Submitted permit':
          'approve': 'Approved permit'
          'reject': 'Rejected permit'
        'Approved permit': {}
        'Rejected permit': {}
      if allowed_transitions[@state]?.hasOwnProperty(action) 
        @state = allowed_transitions[@state][action]
        SUCCESSFUL_TRANSITION
      else 
        TRANSITION_FAILED

  workItemFactory = (state) -> # Abstract factory with strategy
    states = 
      'submitted': (item) -> 
         return item
      'approved': (item) -> 
        if item.transition('approve') then item else TRANSITION_FAILED
      'rejected': (item) -> 
        if item.transition('reject') then item else TRANSITION_FAILED
    myItem = new WorkItem
    myItem.transition('submit') and states[state](myItem)
    
  it 'should when created have an initial state "New permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.state.should.equal 'New permit'

  it 'should when submitted have a state "Submitted permit"', ->
    myWorkItem = workItemFactory('submitted')
    myWorkItem.state.should.equal 'Submitted permit'

  it 'should when approved have a state "Approved permit"', ->
    myWorkItem = workItemFactory('approved')
    myWorkItem.state.should.equal 'Approved permit'

  it 'should when rejected have state "Rejected permit"', ->
    myWorkItem = workItemFactory('rejected')
    myWorkItem.state.should.equal 'Rejected permit'

  it 'should not be able to approve from initial state', ->
    myWorkItem = new WorkItem
    myWorkItem.transition('approve').should.equal TRANSITION_FAILED
    myWorkItem.state.should.equal 'New permit'

  it 'should not be able to reject from initial state', ->
    myWorkItem = new WorkItem
    myWorkItem.transition('reject').should.equal TRANSITION_FAILED
    myWorkItem.state.should.equal 'New permit'

  it 'should not be able to submit from a rejected state', ->
    myWorkItem = workItemFactory('rejected')
    myWorkItem.transition('submit').should.equal TRANSITION_FAILED

  it 'should not be able to submit from an approved state', ->
    myWorkItem = workItemFactory('approved')
    myWorkItem.transition('submit').should.equal TRANSITION_FAILED

  it 'should not allow a spurious transition', ->
    myWorkItem = new WorkItem
    myWorkItem.transition('fubar').should.equal TRANSITION_FAILED

  it 'a factory supplied submitted item should have state "Submitted permit"', ->
    workItemFactory('submitted').state.should.equal 'Submitted permit'

  it 'a factory supplied submitted item should have state "Approved permit"', ->
    workItemFactory('approved').state.should.equal 'Approved permit'

  it 'a factory supplied submitted item should have state "Rejected permit"', ->
    workItemFactory('rejected').state.should.equal 'Rejected permit'
