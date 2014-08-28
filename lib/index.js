(function() {
  var dataFilePath, fs, restify, server, tasks, _;

  _ = require('lodash');

  fs = require('fs-extra');

  restify = require('restify');

  dataFilePath = 'data/tasks.json';

  fs.ensureFileSync(dataFilePath);

  try {
    tasks = fs.readJsonSync(dataFilePath);
  } catch (_error) {
    tasks = [];
  }

  server = restify.createServer();

  server.post('/reload', function(req, res, next) {
    tasks = fs.readJsonSync(dataFilePath);
    res.send(204);
    return next();
  });

  server.get('/tasks', function(req, res, next) {
    res.send(tasks);
    return next();
  });

  server.get('/tasks/:id', function(req, res, next) {
    var id, task;
    id = parseInt(req.params.id);
    task = _.find(tasks, {
      id: id
    });
    if (task == null) {
      next(new restify.ResourceNotFoundError());
    }
    res.send(task);
    return next();
  });

  server.post('/tasks', function(req, res, next) {
    var body;
    body = '';
    req.on('data', function(chunk) {
      return body += chunk;
    });
    return req.on('end', function() {
      var newTask;
      newTask = JSON.parse(body);
      tasks.push(newTask);
      fs.outputJsonSync(dataFilePath, tasks);
      res.send(201, newTask);
      return next();
    });
  });

  server.put('/tasks/:id', function(req, res, next) {
    var body, id, taskIndex;
    id = parseInt(req.params.id);
    taskIndex = _.findIndex(tasks, {
      id: id
    });
    if (taskIndex == null) {
      next(new restify.ResourceNotFoundError());
    }
    body = '';
    req.on('data', function(chunk) {
      return body += chunk;
    });
    return req.on('end', function() {
      var newTask;
      newTask = JSON.parse(body);
      tasks[taskIndex] = newTask;
      fs.outputJsonSync(dataFilePath, tasks);
      res.send(newTask);
      return next();
    });
  });

  server.del('/tasks/:id', function(req, res, next) {
    var id, taskToBeDeleted;
    id = parseInt(req.params.id);
    taskToBeDeleted = _.find(tasks, {
      id: id
    });
    if (taskToBeDeleted == null) {
      next(new restify.ResourceNotFoundError());
    }
    _.pull(tasks, taskToBeDeleted);
    fs.outputJsonSync(dataFilePath, tasks);
    res.send(taskToBeDeleted);
    return next();
  });

  if (require.main === module) {
    server.listen(9999, function() {
      return console.log('Server just started!');
    });
  } else {
    module.exports = server;
  }

}).call(this);

//# sourceMappingURL=index.js.map
