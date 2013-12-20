Component = require '../src/component'

describe "Component", ->
  it "allows stateless components to be defined and rendered", ->
    class Welcome extends Component
      render: ->
        @div ->
          @span "Hello "
          @span @props.name

    component = new Welcome(name: "World")
    expect(component.element.textContent).toBe "Hello World"

  it "allows stateful components to be defined and rendered", ->
    class Welcome extends Component
      render: ->
        @div ->
          @span @props.greeting
          @text " "
          @span @state.name

      getInitialState: ->
        name: "World"

    component = new Welcome(greeting: "Goodnight")
    expect(component.element.textContent).toBe "Goodnight World"
    component.setState(name: "Moon")
    expect(component.element.textContent).toBe "Goodnight Moon"
