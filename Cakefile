{exec} = require 'child_process'

task 'build', 'Build Antidote REST Server from source', ->
  command = 'coffee --compile --output lib/ src/'
  console.log '$', command
  exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    if stdout != '' then console.log stdout
    if stderr != '' then console.log stderr
    console.log "done"

task 'clean', 'Clean build files', ->
  command = 'rm -rf lib/'
  console.log '$', command
  exec command, (err, stdout, stderr) ->
    throw err if err
    if stdout != '' then console.log stdout
    if stderr != '' then console.log stderr
    console.log "done"
