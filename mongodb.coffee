
mongoose = require('mongoose')
$ = require('jquery-deferred')

_DB_NAME = 'test'
_DB = {}
_DB_CONNECT = false

exports.connect = (col, params) ->
  return if _DB[col]?

  DatabaseSchema = new mongoose.Schema(params)
  Database = mongoose.model(col, DatabaseSchema)

  unless _DB_CONNECT
    mongoose.connect "mongodb://localhost/#{_DB_NAME}",
      (err) ->
        if err
          console.log(err)
        else
          _DB_CONNECT = true
          console.log('connection success!')
          _DB[col] = Database
  else
    console.log('already connect!')
    _DB[col] = Database


exports.find = (col, params) ->
  $.Deferred (d) ->
    if _DB[col]?
      db = _DB[col]
      db.find params, (err, docs) ->
        unless err
          console.log docs
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