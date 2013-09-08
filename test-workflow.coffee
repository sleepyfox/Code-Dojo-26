should = require('chai').should()

describe 'A Work item', ->
  class WorkItem
    constructor: ->
      @statename = 'New permit'
    submit: ->
      @statename = 'Submitted permit'      
    approve: ->
      @statename = 'Approved permit'
    reject: ->
      @statename = 'Rejected permit'

  it 'should when created have an initial state "New permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'

  it 'should when submitted have a state "Submitted permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.submit()
    myWorkItem.statename.should.equal 'Submitted permit'

  it 'should when approved have a state "Approved permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.approve()
    myWorkItem.statename.should.equal 'Approved permit'

  it 'should when rejected have state "Rejected permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.reject()
    myWorkItem.statename.should.equal 'Rejected permit'
