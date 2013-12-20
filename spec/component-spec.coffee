Component = require '../src/component'

describe "Component", ->
  it "allows stateless components to be defined and rendered", ->
    class Welcome extends Component
      render: ->
        @div ->
          @text "Hello"
          @span @props.name

    component = new Welcome(name: "Bob")
    element = component.buildElement()
    console.log element.outerHTML
