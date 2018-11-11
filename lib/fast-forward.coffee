FastForwardView = require './fast-forward-view'
{CompositeDisposable, Emitter} = require 'atom'
npm = require '../../npm-plus/lib/npm-plus.js'
git = require 'simple-git'
del = require 'del'
path = atom.project.getPaths()[0]
project_path = "#{ path }\\student_repo"
REPO = 'https://github.com/rmccue/test-repository'

module.exports = FastForward =
  fastForwardView: null
  modalPanel: null
  subscriptions: null
  emitter: null

  activate: (state) ->
    # Construct Emitter, then pass Emitter into construct fastForwardView.
    @emitter = new Emitter()
    @fastForwardView = new FastForwardView(state.fastForwardViewState, @emitter)

    # Create a panel for the plugin, visible by default
    @modalPanel = atom.workspace.addRightPanel(item: @fastForwardView.getElement(), visible: true)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable()

    # Register command that toggles this view
    @subscriptions.add(atom.commands.add('atom-workspace', {'fast-forward:toggle': () => @toggle()}))
    @subscriptions.add(atom.commands.add('atom-workspace', {'fast-forward:installdependencies': () =>  @installDependencies()}))

    @emitter.on 'toggle-button-event', => @toggle()
    @emitter.on 'install-button-event', => @installDependencies()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @emitter.dispose()
    @fastForwardView.destroy()

  serialize: ->
    fastForwardViewState: @fastForwardView.serialize()

  toggle: ->
    console.log 'FastForward was toggled!'
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  installDependencies: ->

    #del project_path

    #handler for just printing out errors for simplegit
    errorlog = (err, idk) ->
      if err != null
        console.log err
      else
        console.log "successfull?"

    ###handler for simple git checkIsRepo
    repoCheck = (err, idk) ->
      if err != null
        console.log err
      if idk
        console.log "#{ project_path } is already a repo"

    #git().cwd(project_path).checkIsRepo repoCheck
    ###

    git().clone REPO, project_path, errorlog
