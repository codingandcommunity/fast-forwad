FastForwardView = require './fast-forward-view'
{CompositeDisposable} = require 'atom'
npm = require '../../npm-plus/lib/npm-plus.js' #make sure you install the npm-plus package and include the file through path name

module.exports = FastForward =
  fastForwardView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->

    @fastForwardView = new FastForwardView(state.fastForwardViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @fastForwardView.getElement(), visible: false)

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
    npm("install")  #this calls the npm function to install the depencies, this calls the function and that works but the fucntion fails rn
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
