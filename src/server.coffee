# Dependencies
# -----

util = require 'util'
restify = require 'restify'


# Server
# -----

server = restify.createServer()


#### Common

server.use restify.CORS()


# Exports
# -----

module.exports = server
