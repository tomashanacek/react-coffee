React = require 'react'

renderComponent = (component, container) ->
  React.renderComponent(component.wrappedComponent, container)

module.exports =
  Component: require './component'
  renderComponent: renderComponent
  React: React
