Component = require '../src/component'

describe "Component", ->
  it "allows stateless components", ->
    class Welcome extends Component
      render: ->
        @div ->
          @span "Hello"
          @span @props.name

    component = new Welcome(name: "World")

    expect(component.element).toMatchMarkup """
      <div>
        <span>Hello</span>
        <span>World</span>
      </div>
    """

  it "allows stateful components", ->
    class Welcome extends Component
      render: ->
        @div ->
          @span @props.greeting
          @span @state.name

      getInitialState: ->
        name: "World"

    component = new Welcome(greeting: "Goodnight")
    expect(component.element).toMatchMarkup """
      <div>
        <span>Goodnight</span>
        <span>World</span>
      </div>
    """

    component.setState(name: "Moon")
    expect(component.element).toMatchMarkup """
      <div>
        <span>Goodnight</span>
        <span>Moon</span>
      </div>
    """

  it "allows components to own other components", ->
    class Owner extends Component
      render: ->
        @div ->
          @div "Owner #{@props.name}"
          @component Ownee, name: "B"

    class Ownee extends Component
      render: ->
        @div "Ownee #{@props.name}"

    component = new Owner(name: "A")
    expect(component.element).toMatchMarkup """
      <div>
        <div>Owner A</div>
        <div>Ownee B</div>
      </div>
    """

  it "allows components have other components as children", ->
    class Owner extends Component
      render: ->
        @div ->
          @component Parent, ->
            @component Child, name: 'A'
            @component Child, name: 'B'

    class Parent extends Component
      render: ->
        @div ->
          @span "I'm the parent. These are my children:"
          @components @props.children

    class Child extends Component
      render: ->
        @div "Child #{@props.name}"

    component = new Owner
    expect(component.element).toMatchMarkup """
      <div>
        <div>
          <span>I'm the parent. These are my children:</span>
          <div>Child A</div>
          <div>Child B</div>
        </div>
      </div>
    """
