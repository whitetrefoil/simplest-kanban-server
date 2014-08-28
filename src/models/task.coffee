mongoose = require 'mongoose'

statuses = [ 'op', 'ip', 'sh', 'dev' ]

taskSchema = mongoose.Schema
  name:
    type: String
    required: true
  assignee:
    type: String
  status:
    type: String
    enum: statuses
    required: true


Task = mongoose.model 'Task', taskSchema


module.exports = Task
