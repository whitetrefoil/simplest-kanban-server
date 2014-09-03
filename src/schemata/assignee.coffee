[ mongoose, db ] = require '../db'


schema = new mongoose.Schema
  name:
    type: String
    required: true
    index: true


module.exports = schema
