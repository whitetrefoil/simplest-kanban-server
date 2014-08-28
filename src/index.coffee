util = require 'util'
server = require './server'


if require.main is module
  server.listen 9999, -> util.log 'Server just started!'
else
  module.exports = server
