namespace '_socket', (exports) ->

  socket = io.connect(null, {port: 7777})
  socket.on 'connect', (message) ->
    #console.log 'socket.io connect'

  socket.on 'message', (message) ->
    _handler[message.method] message

  exports.send = (params) ->
    socket.emit 'message', params
