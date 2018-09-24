FastForwardView = require './fast-forward-view'
{CompositeDisposable} = require 'atom'

module.exports = FastForward =
  fastForwardView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @fastForwardView = new FastForwardView(state.fastForwardViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @fastForwardView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'fast-forward:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @fastForwardView.destroy()

  serialize: ->
    fastForwardViewState: @fastForwardView.serialize()

  toggle: ->
    console.log 'FastForward was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
