namespace '_message', (exports) ->

  exports.send = () ->
    message = $('#thanx-message').text()
    whom = $('#thanx-whom').html()
    who = $('#thanx-who').html()
    _socket.send
      method: 'send_thanx'
      msg: message
      whom: whom
      who: who
