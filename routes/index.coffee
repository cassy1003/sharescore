
#dbWhisper = require("../mongodb/whisper")
userM = require '../model/user'
scoreM = require '../model/score'
conf = require('../conf').getConf()

exports.index = (req, res, params = {}) ->
  res.render 'index',
    title: conf.title
    auth: req.session.auth?.twitter?.user?
    user: userM.getUserInfoFromTwitter(req.session.auth?.twitter?.user)
    conf: conf
    score: scoreM.getScore()
  #dbWhisper.find
  #  query:
  #    to: '0'
  #  option:
  #    sort:
  #      ts: -1
  #.done(
  #  (data) ->
  #    result = []
  #    for k, v of data
  #      if v.id is '0'
  #        name = 'anonymous'
  #      else
  #        # TODO:
  #        # get user_info
  #        name = 'test'
  #      result.push
  #        date: v.date
  #        type: v.type
  #        msg: v.msg
  #        name: name
  #)

exports.signout = (req, res) ->
  delete req.session.auth
  res.redirect conf.domain
