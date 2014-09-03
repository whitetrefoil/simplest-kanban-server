[ mongoose, db ] = require '../db'
schema = require '../schemata/task'


mongoose.model 'Task', schema
