
mongodb = require('../mongodb')

_params = {
  text: String,
  size: Number,
  filename: String,
  savename: String,
  user_id: String,
  screen_name: String,
  status: {type: Number, default: 1}
  ctime: {type: Date, default: new Date()},
}
_col = 'score'

exports.connect = () ->
  mongodb.connect _col, _params

exports.save = (params) ->
  mongodb.save _col, params

exports.find = (params = {}) ->
  query = params.query ? {}
  field = params.field ? {}
  option = params.option ? {}
  mongodb.find _col, query, field, option

exports.getScore = (id) ->
  exports.find
    query:
      _id: id

exports.getUploadedScore = () ->
  exports.find()
