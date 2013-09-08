should = require('chai').should()

describe 'A Work item', ->
  it 'should when created have an initial state "New permit"', ->
    class WorkItem
      constructor: ->
        @statename = 'New permit'
    myWorkItem = new WorkItem
    myWorkItem.statename.should.equal 'New permit'
