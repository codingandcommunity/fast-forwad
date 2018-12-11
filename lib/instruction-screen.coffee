module.exports =
class InstructionView
  constructor: (serializedState, emitter) ->
    # Set Emitter field variable.
    @emitter = emitter

    # Create root element
    @element = document.createElement('div')
    @element.classList.add('fast-forward')

    # Create button element
    @button = document.createElement('button')
    @button.textContent = "Toggle Fast Forward"
    @button.id = "toggle"
    @button.classList.add('btn-primary')
    @button.classList.add('btn')

    # Event listening for button. Emits event to the FastForward module.
    @button.addEventListener('click', () =>
      @emitter.emit('toggle-button-event')
    )
    @element.appendChild(@button)

    # Create heading (title)
    @heading = document.createElement('h1')
    @heading.textContent = "Page Title"
    @element.appendChild(@heading)

    # Create main body section
    @message = document.createElement('div')
    @message.id = "mainbody"
    @message.classList.add('message')
    @element.appendChild(@message)

    @intro = document.createElement('p')
    @intro.textContent = "Main Body section"
    @message.appendChild(@intro)

    # Create sample code section
    @code = document.createElement('pre')
    @message.classList.add('codeSnippet')
    @message.textContent = 'console.log("This is code");'
    @element.appendChild(@message)

    # Create sample hint section
    @hint = document.createElement('div')
    @hint.id = "hint"
    @hint.textContent = "Hint section (default hidden)"
    @element.appendChild(@hint)

    # Create next button
    @next = document.createElement('button')
    @next.classList.add('btn')
    @next.classList.add('btn-primary')
    @next.textContent = "Next"
    @element.appendChild(@next)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @button.removeEventListener('click', 0)
    @element.remove()

  getElement: ->
    @element
