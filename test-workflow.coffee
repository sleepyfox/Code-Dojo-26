should = require('chai').should()

describe 'A Work item', ->
  class WorkItem
    constructor: ->
      @state = 'New permit'
    transition: (action) ->
      allowed_transitions = {
        'New permit': ['submit'],
        'Submitted permit': ['approve', 'reject'],
        'Approved permit': [],
        'Rejected permit': []
      }
      if allowed_transitions[@state].indexOf(action) is -1
        false
      else
        switch action
          when 'submit'
            @state = 'Submitted permit'
          when 'approve'
            @state = 'Approved permit'
          when 'reject'
            @state = 'Rejected permit'
          else
            false
        true

  workItemFactory = (state) -> # Abstract factory with strategy
    states = { 
      'submitted': (item) -> 
         return item
      'approved': (item) -> 
        if item.transition('approve') then item else false
      'rejected': (item) -> 
        if item.transition('reject') then item else false
    }
    myItem = new WorkItem
    if myItem.transition('submit') 
      states[state](myItem)
    else
      false
    
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
    myWorkItem.transition('approve').should.equal false
    myWorkItem.state.should.equal 'New permit'

  it 'should not be able to reject from initial state', ->
    myWorkItem = new WorkItem
    myWorkItem.transition('reject').should.equal false
    myWorkItem.state.should.equal 'New permit'

  it 'should not be able to submit from a rejected state', ->
    myWorkItem = workItemFactory('rejected')
    myWorkItem.transition('submit').should.equal false

  it 'should not be able to submit from an approved state', ->
    myWorkItem = workItemFactory('approved')
    myWorkItem.transition('submit').should.equal false

  it 'a factory supplied submitted item should have state "Submitted permit"', ->
    workItemFactory('submitted').state.should.equal 'Submitted permit'

  it 'a factory supplied submitted item should have state "Approved permit"', ->
    workItemFactory('approved').state.should.equal 'Approved permit'

  it 'a factory supplied submitted item should have state "Rejected permit"', ->
    workItemFactory('rejected').state.should.equal 'Rejected permit'
