# Dependencies
# -----

util = require 'util'
mongoose = require 'mongoose'


# Configuration
# -----

dbPath = 'mongodb://localhost/simplest-kanban'


# Bootstrap
# -----

mongoose.connect dbPath
db = mongoose.connection
db.on 'error', util.error.bind util, 'MongoDB error:'
db.once 'open', -> util.log 'MongoDB connection initialized!'


# Exports
# -----

module.exports = [ mongoose, db ]
