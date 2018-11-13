const fs = require('fs')

module.exports = (function() {
  var backupChanges = () => {
    var editors = atom.workspace.getTextEditors()
    var projectPath = atom.project.getPaths()
    fs.stat(`${projectPath}\\tmp\\`, (err, stats) => {
      if (err && err.code === 'ENOENT') {
        fs.mkdirSync(`${projectPath}\\tmp\\`)
      } else {
        console.log('Directory already exists.')
      }
    })
  }
  return {
    backupChanges: backupChanges
  }
})()
