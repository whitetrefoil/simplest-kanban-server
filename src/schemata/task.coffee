config = require '../config'
[ mongoose, db ] = require '../db'


schema = new mongoose.Schema
  name:
    type: String
    required: true
  assignee:
    type: String
  status:
    type: String
    enum: config.statuses
    required: true


module.exports = schema
