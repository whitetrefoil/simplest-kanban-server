(function() {
  var Task, db, mongoose, restify, server, util, _, _ref;

  util = require('util');

  _ = require('lodash');

  restify = require('restify');

  _ref = require('./db'), mongoose = _ref[0], db = _ref[1];

  Task = require('./models/task');

  server = restify.createServer();

  server.use(restify.CORS());

  server.get('/tasks', function(req, res, next) {
    return Task.find(function(err, tasks) {
      res.send(tasks);
      return next();
    });
  });

  server.get('/tasks/:id', function(req, res, next) {
    var id;
    id = req.params.id;
    return Task.findById(id, function(err, task) {
      if (err != null) {
        next(new restify.ResourceNotFoundError(err.toString()));
      }
      res.send(task);
      return next();
    });
  });

  server.post('/tasks', function(req, res, next) {
    var body;
    body = '';
    req.on('data', function(chunk) {
      return body += chunk;
    });
    return req.on('end', function() {
      return Task.create(JSON.parse(body), function(err, task) {
        if (err != null) {
          next(new restify.InvalidContentError(err.toString()));
        }
        res.send(201, task);
        return next();
      });
    });
  });

  server.put('/tasks/:id', function(req, res, next) {
    var body, id;
    id = req.params.id;
    body = '';
    req.on('data', function(chunk) {
      return body += chunk;
    });
    return req.on('end', function() {
      return Task.findById(id, function(err, task) {
        if (err != null) {
          next(new restify.ResourceNotFoundError(err.toString()));
        }
        task.set(JSON.parse(body));
        return task.save(function(err, newTask) {
          if (err != null) {
            next(new restify.InvalidContentError(err.toString()));
          }
          res.send(newTask);
          return next();
        });
      });
    });
  });

  server.del('/tasks/:id', function(req, res, next) {
    var id;
    id = req.params.id;
    return Task.findByIdAndRemove(id, function(err, deleted) {
      if (deleted == null) {
        next(new restify.ResourceNotFoundError());
      }
      res.send(deleted);
      return next();
    });
  });

  module.exports = server;

}).call(this);

//# sourceMappingURL=server.js.map
