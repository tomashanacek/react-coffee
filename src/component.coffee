React = require 'react'
Delegator = require 'delegato'
PropertyAccessors = require 'property-accessors'
DOMBuilder = require './dom-builder'

module.exports =
class Component
  Delegator.includeInto(this)
  PropertyAccessors.includeInto(this)
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

  @::lazyAccessor 'element', ->
    container = document.createElement('div')
    React.renderComponent(@wrappedComponent, container)
    container.firstChild
