
io = require("socket.io")
crypto = require("crypto")
handler = require("./handler")

_send = () ->
_sendBroadcast = () ->
_sendEmit = () ->

exports.connect = (server) ->
  socket = io.listen server, {'log level': 1}
  socket.sockets.on 'connection', (client) ->

    client.on 'message', (message) ->
      handler[message.method] message

    client.on 'disconnect', () ->
      #client.broadcast()

    _sendBroadcastEmit = (params) ->
      client.broadcast.emit params.emit, params

    _sendEmit = (params) ->
      client.emit params.emit, params

exports.sendBroadcastEmit = (params) ->
  _sendBroadcastEmit(params)

exports.sendEmit = (params) ->
  _sendEmit(params)

exports.sendAlert = (message) ->
  exports.sendEmit
    emit: 'message'
    method: 'showAlert'
    message: message
