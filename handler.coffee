
socket = require("./socket")

exports.whisper = (message) ->
  if message.whom is '0'
    socket.sendEmit
      emit: 'message'
      method: 'getFeed'
      text: exports.makeFeed(message)

exports.makeFeed = (params) ->
  if params.who is '0'
    name = 'no name'
  else
    name = 'test'

  date = new Date()
  y = date.getFullYear()
  m = date.getMonth() + 1
  d = date.getDate()
  h = date.getHours()
  mi = date.getMinutes()

  html = """
   <li class='feed'>
    <div class='feed-head'>
      <div class='name'>#{name}</div>
      <div class='info'>#{y}/#{m}/#{d} #{h}:#{mi}</div>
    </div>
    <hr color='black' size='3'>
    <div class='feed-text'>#{params.msg}</div>
   </li>
   <hr color='black' size='3'>
  """
