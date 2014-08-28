# Dependencies
# -----

_ = require 'lodash'
fs = require 'fs-extra'
restify = require 'restify'


# Configuration
# -----

dataFilePath = 'data/tasks.json'


# Bootstrap
# -----

fs.ensureFileSync dataFilePath
try
  tasks = fs.readJsonSync dataFilePath
catch
  tasks = []


# Server
# -----

server = restify.createServer()

#### Reloading

server.post '/reload', (req, res, next) ->
  tasks = fs.readJsonSync dataFilePath
  res.send 204
  next()

#### Tasks CRUD

server.get '/tasks', (req, res, next) ->
  res.send tasks
  next()


server.get '/tasks/:id', (req, res, next) ->
  id = parseInt req.params.id
  task = _.find tasks, { id: id }
  next new restify.ResourceNotFoundError() unless task?
  res.send task
  next()


server.post '/tasks', (req, res, next) ->
  body = ''
  req.on 'data', (chunk) -> body += chunk
  req.on 'end', ->
    newTask = JSON.parse body
    tasks.push newTask
    fs.outputJsonSync dataFilePath, tasks
    res.send 201, newTask
    next()


server.put '/tasks/:id', (req, res, next) ->
  id = parseInt req.params.id
  taskIndex = _.findIndex tasks, { id: id }
  next new restify.ResourceNotFoundError() unless taskIndex?
  body = ''
  req.on 'data', (chunk) -> body += chunk
  req.on 'end', ->
    newTask = JSON.parse body
    tasks[taskIndex] = newTask
    fs.outputJsonSync dataFilePath, tasks
    res.send newTask
    next()


server.del '/tasks/:id', (req, res, next) ->
  id = parseInt req.params.id
  taskToBeDeleted = _.find tasks, { id: id }
  next new restify.ResourceNotFoundError() unless taskToBeDeleted?
  _.pull tasks, taskToBeDeleted
  fs.outputJsonSync dataFilePath, tasks
  res.send taskToBeDeleted
  next()


# Exports
# -----

if require.main is module
  server.listen 9999, -> console.log 'Server just started!'
else
  module.exports = server
