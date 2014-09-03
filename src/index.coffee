util = require 'util'

require './db'
require './models'
server = require './server'
require './apis'


if require.main is module
  server.listen 9999, -> util.log 'Server just started!'
else
  module.exports = server
