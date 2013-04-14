
dbWhisper = require("../mongodb/whisper")

_title = 'whisper'
exports.index = (req, res) ->
  dbWhisper.find
    query:
      to: '0'
    option:
      sort:
        ts: -1
  .done(
    (data) ->
      result = []
      for k, v of data
        if v.id is '0'
          name = 'anonymous'
        else
          # TODO:
          # get user_info
          name = 'test'
        result.push
          date: v.date
          type: v.type
          msg: v.msg
          name: name
      res.render 'index',
        title: _title
        result: result
        auth: req.session.auth?
  )

exports.signout = (req, res) ->
  delete req.session.auth
  res.redirect 'http://whisper.q-x-p.net/'
