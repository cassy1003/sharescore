
mongodb = require('../mongodb')

_params = {
  id: String,
  name: String,
  screen_name: String,
  image: {type: String, default: null},
  time_zone: String,
  lang: String,
  c_time: Date,
}
# Actualy, collection name is 'users' in mongodb
_col = 'user'

exports.connect = () ->
  mongodb.connect _col, _params

exports.save = (params) ->
  mongodb.save _col, params

exports.find = (params = {}) ->
  query = params.query ? {}
  field = params.field ? {}
  option = params.option ? {}
  mongodb.find _col, query, field, option

exports.getUser = (id) ->
  exports.find
    query:
      id: id
