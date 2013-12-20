Component = require '../src/component'

describe "Component", ->
  it "allows stateless components to be defined and rendered", ->
    class Welcome extends Component
      render: ->
        @div ->
          @span "Hello"
          @span @props.name

    component = new Welcome(name: "World")
    expect(component.element.textContent).toBe "HelloWorld"
