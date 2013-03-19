
io = require("socket.io")
crypto = require("crypto")
handler = require("./handler")

exports.connect = (server) ->
  socket = io.listen server, {'log level': 1}
  socket.sockets.on 'connection', (client) ->

    client.on 'message', (message) ->
      handler[message.method] message

    client.on 'send data', (message) ->
      client.emit 'push data', message
      #client.broadcast message

    client.on 'disconnect', () ->
      #client.broadcast()

exports.routeMessage = (message) ->
  type = message.type

