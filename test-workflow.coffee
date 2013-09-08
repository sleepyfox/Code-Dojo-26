should = require('chai').should()

describe 'A Work item', ->
  class WorkItem
    constructor: ->
      @state = 'New permit'
    submit: ->
      if @state is 'New permit'
        @state = 'Submitted permit'
        true
      else
        false
    approve: ->
      if @state is 'Submitted permit'
        @state = 'Approved permit'
        true
      else 
        false
    reject: ->
      if @state is 'Submitted permit'
        @state = 'Rejected permit'
        true
      else
        false

  workItemFactory = (state) -> # Abstract factory with strategy
    states = { 
      'submitted': (item) -> 
         return item
      'approved': (item) -> 
        if item.approve() then item else false
      'rejected': (item) -> 
        if item.reject() then item else false
    }
    myItem = new WorkItem
    if myItem.submit() 
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
    myWorkItem.approve().should.equal false
    myWorkItem.state.should.equal 'New permit'

  it 'should not be able to reject from initial state', ->
    myWorkItem = new WorkItem
    myWorkItem.reject().should.equal false
    myWorkItem.state.should.equal 'New permit'

  it 'should not be able to submit from a rejected state', ->
    myWorkItem = workItemFactory('rejected')
    myWorkItem.submit().should.equal false

  it 'should not be able to submit from an approved state', ->
    myWorkItem = workItemFactory('approved')
    myWorkItem.submit().should.equal false

  it 'a factory supplied submitted item should have state "Submitted permit"', ->
    workItemFactory('submitted').state.should.equal 'Submitted permit'

  it 'a factory supplied submitted item should have state "Approved permit"', ->
    workItemFactory('approved').state.should.equal 'Approved permit'

  it 'a factory supplied submitted item should have state "Rejected permit"', ->
    workItemFactory('rejected').state.should.equal 'Rejected permit'
