React = require 'react'
Delegator = require 'delegato'
DOMBuilder = require './dom-builder'

module.exports =
class Component
  Delegator.includeInto(this)
  DOMBuilder.includeInto(this)

  @getWrappedComponentClass: ->
    @wrappedComponentClass ?= React.createClass
      displayName: @name
      render: -> @wrapper.render()

  @delegatesProperties 'props', 'state', toProperty: 'wrappedComponent'

  constructor: (props) ->
    @wrappedComponent = @constructor.getWrappedComponentClass()(props)
    @wrappedComponent.wrapper = this

  render: ->
    throw new Error("You must implement ::render on component #{@constructor.displayName ? @constructor.name}")

  buildElement: ->
    container = document.createElement('div')
    React.renderComponent(@wrappedComponent, container)
    container.firstChild
