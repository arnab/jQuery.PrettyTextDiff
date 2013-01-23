{exec} = require 'child_process'

srcFile = 'jquery.pretty-text-diff'

task 'compile', 'Build project from *.coffee to *.js', ->
  exec "coffee --compile #{srcFile}.coffee", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

task 'minify', 'Minify js into min.js', ->
  exec "uglifyjs #{srcFile}.js --o #{srcFile}.min.js --comments", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

task 'build', 'compile and minify', ->
  exec "cake compile && cake minify", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
