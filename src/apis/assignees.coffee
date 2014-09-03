restify = require 'restify'

[ mongoose, db ] = require '../db'
server = require '../server'


Assignee = mongoose.model 'Assignee'


##### Assignees CRUD

server.get '/assignees', (req, res, next) ->
  Assignee.find (err, tasks) ->
    res.send tasks
    next()


server.get '/assignees/:name', (req, res, next) ->
  name = req.params.name
  Assignee.findOne { name: name } , (err, assignee) ->
    return next new restify.InvalidContentError(err.toString()) if err?
    return next new restify.ResourceNotFoundError() unless assignee?
    res.send assignee
    next()


server.post '/assignees', (req, res, next) ->
  body = ''
  req.on 'data', (chunk) -> body += chunk
  req.on 'end', ->
    newAssignee = JSON.parse(body)
    newName = newAssignee.name
    return next new restify.InvalidContentError('"name" is required') unless newName?
    Assignee.findOne { name: newName }, (err, existing) ->
      return next new restify.InvalidContentError(err.toString()) if err?
      return next new restify.ConflictError('This assignee is existing') if existing?
      Assignee.create newAssignee, (err, assignee) ->
        return next new restify.InvalidContentError(err.toString()) if err?
        res.send 201, assignee
        next()


server.put '/assignees/:name', (req, res, next) ->
  name = req.params.name
  body = ''
  req.on 'data', (chunk) -> body += chunk
  req.on 'end', ->
    newAssignee = JSON.parse(body)
    newName = newAssignee.name
    return next new restify.InvalidContentError('"name" is required') unless newName?
    Assignee.findOne { name: name } , (err, assignee) ->
      return next new restify.InvalidContentError(err.toString()) if err?
      return next new restify.ResourceNotFoundError() unless assignee?
      Assignee.findOne { name: newName }, (err, existing) ->
        return next new restify.InvalidContentError(err.toString()) if err?
        return next new restify.ConflictError('This assignee is existing') if existing?
        assignee.set JSON.parse(body)
        assignee.save (err, newAssignee) ->
          return next new restify.InvalidContentError(err.toString()) if err?
          res.send newAssignee
          next()


server.del '/assignees/:name', (req, res, next) ->
  name = req.params.name
  Assignee.findOneAndRemove { name: name } , (err, deleted) ->
    return next new restify.ResourceNotFoundError() unless deleted?
    res.send deleted
    next()
