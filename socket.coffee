
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

    _send = (params) ->
      client.send params

    _sendBroadcast = (params) ->
      client.broadcast message

    _sendEmit = (params) ->
      client.emit params.emit, params

    client.on 'disconnect', () ->
      #client.broadcast()

exports.send = (params) ->
  _send(params)

exports.sendBroadcast = (params) ->
  _sendBroadcast(params)

exports.sendEmit = (params) ->
  _sendEmit(params)

