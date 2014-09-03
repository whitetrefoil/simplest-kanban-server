[ mongoose, db ] = require '../db'
schema = require '../schemata/assignee'


mongoose.model 'Assignee', schema
