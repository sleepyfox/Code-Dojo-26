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
      @state = 'Rejected permit'
      return true

  it 'should when created have an initial state "New permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.state.should.equal 'New permit'

  it 'should when submitted have a state "Submitted permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.submit().should.equal true
    myWorkItem.state.should.equal 'Submitted permit'

  it 'should when approved have a state "Approved permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.submit().should.equal true
    myWorkItem.approve().should.equal true
    myWorkItem.state.should.equal 'Approved permit'

  it 'should when rejected have state "Rejected permit"', ->
    myWorkItem = new WorkItem
    myWorkItem.reject().should.equal true
    myWorkItem.state.should.equal 'Rejected permit'

  it 'should not be able to approve from initial state', ->
    myWorkItem = new WorkItem
    myWorkItem.approve().should.equal false
    myWorkItem.state.should.equal 'New permit'
