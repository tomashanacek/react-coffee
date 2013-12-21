React = require 'react'
Delegator = require 'delegato'
PropertyAccessors = require 'property-accessors'
DOMBuilder = require './dom-builder'
ExampleReactComponent = React.createClass(render: ->).componentConstructor.prototype

module.exports =
class Component
  Delegator.includeInto(this)
  PropertyAccessors.includeInto(this)
  DOMBuilder.includeInto(this)

  for key, value of ExampleReactComponent when key isnt 'constructor' and typeof value is 'function'
    @delegatesMethod key, toProperty: 'wrappedComponent'

  @delegatesProperties 'props', 'state', toProperty: 'wrappedComponent'

  @getWrappedComponentClass: ->
    @wrappedComponentClass ?= React.createClass
      displayName: @name
      render: -> @wrapper.render()
      getInitialState: -> @wrapper.getInitialState?()

  constructor: (args...) ->
    @wrappedComponent = @constructor.getWrappedComponentClass()(args...)
    @wrappedComponent.wrapper = this

  render: ->
    throw new Error("You must implement ::render on component #{@constructor.displayName ? @constructor.name}")

  @::lazyAccessor 'element', ->
    container = document.createElement('div')
    React.renderComponent(@wrappedComponent, container)
    container.firstChild
