(function() {
  var server, util;

  util = require('util');

  server = require('./server');

  if (require.main === module) {
    server.listen(9999, function() {
      return util.log('Server just started!');
    });
  } else {
    module.exports = server;
  }

}).call(this);

//# sourceMappingURL=index.js.map
