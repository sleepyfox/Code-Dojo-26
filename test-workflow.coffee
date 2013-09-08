should = require('chai').should()

describe 'A Work item', ->
  it 'should when created have an initial state "New permit"', ->
    class WorkItem
      constructor: ->
        @statename = 'New permit'

    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'

  it 'should when submitted have a state "Submitted permit"', ->
    class WorkItem
      constructor: ->
        @statename = 'New permit'
      submit: ->
        @statename = 'Submitted permit'

    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'
    myWorkItem.submit()
    myWorkItem.statename.should.equal 'Submitted permit'

  it 'should when approved have a state "Approved permit"', ->
    class WorkItem
      constructor: ->
        @statename = 'New permit'
      approve: ->
        @statename = 'Approved permit'

    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'
    myWorkItem.approve()
    myWorkItem.statename.should.equal 'Approved permit'

