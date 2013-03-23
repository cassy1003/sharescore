
io = require("socket.io")
crypto = require("crypto")
handler = require("./handler")

_sendIdEmit = () ->
_sendAllEmit = () ->

exports.connect = (server) ->
  socket = io.listen server, {'log level': 1}
  socket.sockets.on 'connection', (client) ->

    client.on 'message', (message) ->
      handler[message.method] message

    client.on 'disconnect', () ->
      #client.broadcast()

    _sendIdEmit = (params) ->
      socket.sockets.socket(client.id).emit params.emit, params

    _sendAllEmit = (params) ->
      socket.sockets.emit params.emit, params

exports.sendIdEmit = (params) ->
  _sendIdEmit(params)

exports.sendAllEmit = (params) ->
  _sendAllEmit(params)

exports.sendAlert = (message) ->
  exports.sendIdEmit
    emit: 'message'
    method: 'showAlert'
    message: message
