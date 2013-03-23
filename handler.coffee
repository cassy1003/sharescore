
socket = require("./socket")
dbWhisper = require("./mongodb/whisper")

exports.whisper = (message) ->
  dbWhisper.save
    id: message.who
    to: message.whom
    msg: message.msg
    type: message.type
    date: exports.getDate()
    ts: date.getTime()

  if message.whom is '0'
    socket.sendAllEmit
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
   <div class='feed-entry'>
    <div class='feed-head'>
      <div class='name'>#{name}</div>
      <div class='info'>#{params.date}</div>
    </div>
    <hr color='black' size='3'>
    <div class='feed-text'>#{params.msg}</div>
    <div id="star" class="btn btn-small"><i class="icon-star"></i></div>
   </div>
  """

exports.getDate = () ->
  date = new Date()
  y = date.getFullYear()
  m = date.getMonth() + 1
  d = date.getDate()
  h = date.getHours()
  mi = date.getMinutes()
  "#{y}/#{m}/#{d} #{h}:#{mi}"
