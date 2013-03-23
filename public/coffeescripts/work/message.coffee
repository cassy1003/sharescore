namespace '_handler', (exports) ->

  exports.sendMessage = () ->
    message = $('#send-message').val()
    unless message
      alert 'input message'
      return

    whom = $('#send-whom').attr 'value'
    who = $('#send-who').attr 'value'
    type =  $('#send-type').attr 'value'
    _socket.send
      method: 'whisper'
      type: type
      msg: message
      whom: whom
      who: who
    $('#send-message').val('')

  exports.selectSendMenu = (label, menu) ->
    $("#send-#{menu}").attr 'value', label
    $("#send-#{menu}").text $("#send-#{menu}-#{label}").text()

  exports.getFeed = (params) ->
    $("#feed-area").prepend params.text

  exports.showAlert = (params) ->
    alert params.message
