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
    @button.classList.add('btn-primary')
    @button.classList.add('btn')

    # Event listening for button. Emits event to the FastForward module.
    @button.addEventListener('click', () =>
      @emitter.emit('toggle-button-event')
    )
    @element.appendChild(@button)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @button.removeEventListener('click', 0)
    @element.remove()

  getElement: ->
    @element
