
socket = require("./socket")
dbWhisper = require("./mongodb/whisper")

exports.whisper = (message) ->
  date = new Date()
  y = date.getFullYear()
  m = date.getMonth() + 1
  d = date.getDate()
  h = date.getHours()
  mi = date.getMinutes()
  message.date = "#{y}/#{m}/#{d} #{h}:#{mi}"

  dbWhisper.save
    id: message.who
    to: message.whom
    msg: message.msg
    type: message.type
    date: message.date
    ts: date.getTime()

  if message.whom is '0'
    socket.sendBroadcastEmit
      emit: 'message'
      method: 'getFeed'
      text: exports.makeFeed(message)

  socket.sendAlert 'ささやきました.'

exports.getWhisper = () ->
  dbWhisper.find().done(
    (result) ->
      console.log result
  )

exports.makeFeed = (params) ->
  if params.who is '0'
    name = 'anonymous'
  else
    name = 'test'

  html = """
   <li class='feed'>
    <div class='feed-head'>
      <div class='name'>#{name}</div>
      <div class='info'>#{params.date}</div>
    </div>
    <hr color='black' size='3'>
    <div class='feed-text'>#{params.msg}</div>
   </li>
   <hr color='black' size='3'>
  """
