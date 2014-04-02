#!/usr/bin/env coffee 
#
# # KDC Mini
#
{spawn} = require 'child_process'
fs      = require 'fs'
path    = require 'path'




# ## loadManifest()
#
# ### Args
# - appPath: Path of the app. Excluding the manifest.
# - opts: Optional
#   - opts.name: The name of the manifest file. Default: `manifest.json`
# - callback(err, manifest): A function called when the manifest is loaded.
#   0. err: An error object, if one is encountered. `null` otherwise.
#   1. manifest: The manifest object, unmodified.
loadManifest = (appPath, opts={}, callback=->) ->
  if opts instanceof Function then [callback, opts] = [opts, {}]
  if not appPath? then return callback new Error 'appPath is required'

  opts.name     ?= 'manifest.json'

  readPath     = path.join appPath, opts.name
  readFileOpts = encoding: 'utf-8'

  fs.readFile readPath, readFileOpts, (err, data) ->
    if err? then return callback err
    try
      data = JSON.parse data
    catch err
      return callback err
    callback null, data



# ## exec()
#
# ### Args
# - argv: A list of arguments for this process.
# - log: A function which will be used to print on, if any printing from this
#     process even occurs. Default: `console.error`, which is `STDERR`
exec = (argv, log=console.error) ->
  appPath  = path.join argv[2] ? process.cwd()
  loadManifest appPath, (err, manifest) ->
    if err?
      log err
      return process.exit 1

    kdcPath = path.join path.dirname(require.resolve 'kdc'), 'bin', 'kdc'
    build   = manifest.build ? "#{kdcPath} #{appPath}"
    args    = build.split ' '
    bin     = args.shift()

    # Create our process
    proc  = spawn bin, args, cwd: appPath
    # pipe stdout and stderr to this process
    proc.stdout.pipe process.stdout
    proc.stderr.pipe process.stderr
    # and finally, exit when it exits, with the same code.
    proc.on 'close', (code) -> process.exit code




exports.loadManifest = loadManifest
exports.exec         = exec
if require.main is module then exec process.argv
