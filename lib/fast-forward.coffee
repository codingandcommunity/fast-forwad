FastForwardView = require './fast-forward-view'
{CompositeDisposable, Emitter} = require 'atom'
git = require 'simple-git'
fs = require 'fs'
cmd = require 'node-cmd'

project_directory = process.env['USERPROFILE'] + "\\Documents\\MyCodingAndCommunityProjects"

plugin_path = atom.project.getPaths()[0]

#have these entered in the plugin
REPO = 'https://github.com/rmccue/test-repository'
name = 'first project'
base_project_path = project_directory + "\\My_first_project"
project_path = base_project_path

count = 0


handler = (err) ->
  if err != null
    console.log err

fs.mkdir(project_directory, handler)

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

  #brads button
  installDependencies: ->

    #clones the repo inside of the project path
    clone = () ->
      git().clone REPO, project_path, errorlog

    #handler for just printing out errors for simplegit which just prints out the error
    errorlog = (err, idk) ->
      if err != null
        console.log err

    #handler for chekcing the status for the directory
    projectStatHandler = (err, stat) ->

      #if the directory exists then create the directory and then the callback function clones the repo
      if err && err.code == "ENOENT"
        fs.mkdir(project_path, clone)
        console.log "made the Directory at #{ project_path }"

      #otherwise add one to project path and then check the path again
      else
        console.log('Directory already exists.')
        count = count + 1
        project_path = base_project_path + "(" + count + ")"

        projectCheck()

    #calls fs.stat which checks the status of a directory
    projectCheck = () ->
      fs.stat project_path, projectStatHandler

    #the button code to find the correct project directory and clone it from github
    projectCheck()
    count = 0

    #handler to print out stuff from cmd
    cmdHandler = (err, data, stderr) ->
      console.log err
      console.log data
      console.log stderr

    #install the dependencies from the newly cloned project
    cmd.get(
      '
        dir
      ', cmdHandler)
