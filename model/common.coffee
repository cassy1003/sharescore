
exports.getDate = (date = null) ->
  date = new Date() unless date
  y = date.getFullYear()
  m = date.getMonth() + 1
  d = date.getDate()
  h = date.getHours()
  mi = date.getMinutes()
  "#{y}/#{m}/#{d} #{h}:#{mi}"
