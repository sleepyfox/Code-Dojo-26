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

  submittedWorkItem = -> # Factory
    item = new WorkItem
    if item.submit() is true
      item
    else
      false

  approvedWorkItem = -> # factory
    item = submittedWorkItem()
    if item.approve() is true
      item
    else
      false

  rejectedWorkItem = -> # factory
    item = submittedWorkItem()
    if item.reject() is true
      item
    else
      false

  it 'should when created have an initial state "New permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.state.should.equal 'New permit'

  it 'should when submitted have a state "Submitted permit"', ->
    myWorkItem = submittedWorkItem()
    myWorkItem.state.should.equal 'Submitted permit'

  it 'should when approved have a state "Approved permit"', ->
    myWorkItem = approvedWorkItem()
    myWorkItem.state.should.equal 'Approved permit'

  it 'should when rejected have state "Rejected permit"', ->
    myWorkItem = rejectedWorkItem()
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
    myWorkItem = rejectedWorkItem()
    myWorkItem.submit().should.equal false

  it 'should not be able to submit from an approved state', ->
    myWorkItem = approvedWorkItem()
    myWorkItem.submit().should.equal false

  it 'a factory supplied submitted item should have state "Submitted permit"', ->
    submittedWorkItem().state.should.equal 'Submitted permit'