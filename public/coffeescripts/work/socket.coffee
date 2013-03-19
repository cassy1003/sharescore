namespace '_socket', (exports) ->

  socket = io.connect(null, {port: 7777})
  socket.on 'connect', (message) ->
    console.log 'socket.io connect'

  socket.on 'message', (message) ->
    console.log message

  exports.send = (params) ->
    console.log params
    socket.emit 'message', params
