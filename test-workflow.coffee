should = require('chai').should()

describe 'A Work item', ->
  class WorkItem
    constructor: ->
      @statename = 'New permit'
    submit: ->
      @statename = 'Submitted permit'      
    approve: ->
      @statename = 'Approved permit'

  it 'should when created have an initial state "New permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'

  it 'should when submitted have a state "Submitted permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'
    myWorkItem.submit()
    myWorkItem.statename.should.equal 'Submitted permit'

  it 'should when approved have a state "Approved permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'
    myWorkItem.approve()
    myWorkItem.statename.should.equal 'Approved permit'

