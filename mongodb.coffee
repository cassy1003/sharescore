
mongoose = require('mongoose')
$ = require('jquery-deferred')

_DB_NAME = 'test'
_DB = {}

exports.database = () ->
  mongoose.connect "mongodb://localhost/#{_DB_NAME}",
    (err) ->
      if err
        console.log(err)
      else
        console.log('connection success!')

exports.connect = (col, params) ->
  return if _DB[col]?

  DatabaseSchema = new mongoose.Schema(params)
  Database = mongoose.model(col, DatabaseSchema)

  _DB[col] = Database

exports.find = (col, query, field = {}, option = {}) ->
  $.Deferred (d) ->
    if _DB[col]?
      db = _DB[col]
      db.find query, field, option, (err, docs) ->
        unless err
          d.resolve docs
        else
          console.log("error function of find")
          d.reject()
    else
      d.reject()

exports.save = (col, params) ->
  if _DB[col]?
    db = new _DB[col]

    for k, v of params
      db[k] = v

    db.save (err) ->
      unless err
        # console.log 'save'
        return
      else
        # TODO:
        # socket.errorSend 'alert message'
        console.log err

exports.update = (col, params) ->
  if _DB[col]?
    db = new _DB[col]
    db.update params.where, {$set: params.set}, { upsert: false, multi: true}, (err) ->
      #exports.find({db: db_name})
      console.log 'update'

exports.disconnect = () ->
  mongoose.disconnect()
