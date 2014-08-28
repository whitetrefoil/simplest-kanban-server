(function() {
  var db, dbPath, mongoose, util;

  util = require('util');

  mongoose = require('mongoose');

  dbPath = 'mongodb://localhost/simplest-kanban';

  mongoose.connect(dbPath);

  db = mongoose.connection;

  db.on('error', util.error.bind(util, 'MongoDB error:'));

  db.once('open', function() {
    return util.log('MongoDB connection initialized!');
  });

  module.exports = [mongoose, db];

}).call(this);

//# sourceMappingURL=db.js.map
