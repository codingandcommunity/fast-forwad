module.exports =
class FastForwardView
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
    @heading.textContent = "Welcome to Warp Drive!"
    @element.appendChild(@heading)

    # Create main body section
    @message = document.createElement('div')
    @message.id = "mainbody"
    @message.classList.add('message')
    @element.appendChild(@message)

    @intro = document.createElement('p')
    @intro.textContent = "Warp Drive is here to accelerate your journey to become a great programmer!"
    @message.appendChild(@intro)
    @intro = document.createElement('p')
    @intro.textContent = "Let's get started!"
    @message.appendChild(@intro)

    # Create next button
    @next = document.createElement('button')
    @next.classList.add('btn')
    @next.classList.add('btn-primary')
    @next.textContent = "Start"
    @element.appendChild(@next)

    # Event listening for button. Emits event to the FastForward module.
    @next.addEventListener('click', () =>
      console.log("Next clicked!")
    )

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @button.removeEventListener('click', 0)
    @element.remove()

  getElement: ->
    @element
