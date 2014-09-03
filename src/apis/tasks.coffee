restify = require 'restify'

[ mongoose, db ] = require '../db'
server = require '../server'


Task = mongoose.model 'Task'


##### Tasks CRUD

server.get '/tasks', (req, res, next) ->
  Task.find (err, tasks) ->
    res.send tasks
    next()


server.get '/tasks/:id', (req, res, next) ->
  id = req.params.id
  Task.findById id, (err, task) ->
    next new restify.ResourceNotFoundError(err.toString()) if err?
    res.send task
    next()


server.post '/tasks', (req, res, next) ->
  body = ''
  req.on 'data', (chunk) -> body += chunk
  req.on 'end', ->
    Task.create JSON.parse(body), (err, task) ->
      next new restify.InvalidContentError(err.toString()) if err?
      res.send 201, task
      next()


server.put '/tasks/:id', (req, res, next) ->
  id = req.params.id
  body = ''
  req.on 'data', (chunk) -> body += chunk
  req.on 'end', ->
    Task.findById id, (err, task) ->
      next new restify.ResourceNotFoundError(err.toString()) if err?
      task.set JSON.parse(body)
      task.save  (err, newTask) ->
        next new restify.InvalidContentError(err.toString()) if err?
        res.send newTask
        next()


server.del '/tasks/:id', (req, res, next) ->
  id = req.params.id
  Task.findByIdAndRemove id, (err, deleted) ->
    next new restify.ResourceNotFoundError() unless deleted?
    res.send deleted
    next()

