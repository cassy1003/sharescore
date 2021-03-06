
mongodb = require('../mongodb')

_params = {
  id: String,
  to: String,
  msg: String,
  type: String,
  date: String,
  like: {type: Number, default: 0},
  comments: {type: Number, default: 0},
  ts: Date,
}
# Actualy, collection name is 'whispers' in mongodb
_col = 'whisper'

exports.connect = () ->
  mongodb.connect _col, _params

exports.save = (params) ->
  mongodb.save _col, params

exports.find = (params = {}) ->
  query = params.query ? {}
  field = params.field ? {}
  option = params.option ? {}
  mongodb.find _col, query, field, option
