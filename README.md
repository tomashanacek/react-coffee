This is an attempt to make Facebook's react library more usable from
CoffeeScript without escaping into JSX or painfully contorting syntax. Here's
what I have so far.

```coffee
{React, Component, renderComponent} = require 'react-coffee'

class TodoList extends Component
  render: ->
    @ul ->
      @li text for text in this.props.items

class TodoApp extends Component
  getInitialState: ->
    items: []
    text: ''

  onChange: (e) =>
    @setState(text: e.target.value)

  handleSubmit: (e) =>
    e.preventDefault()

    nextItems = @state.items.concat([@state.text])
    nextText = ''
    @setState(items: nextItems, text: nextText)

    @refs.nameInput.getDOMNode().focus()

  render: ->
    @div ->
      @h3 'TODO'
      @component TodoList, items: @state.items
      @form onSubmit: @handleSubmit, ->
        @input onChange: @onChange, ref: 'nameInput', value: @state.text
        @button "Add ##{@state.items.length + 1}"

component = new TodoApp()
renderComponent(component, document.getElementById('app'))
```
