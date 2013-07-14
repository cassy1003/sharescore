
dbUser = require("../mongodb/user")
userM = require '../model/user'
scoreM = require '../model/score'
conf = require('../conf').getConf()

exports.index = (req, res, params = {}) ->
  user = req.session.auth?.twitter?.user
  scoreM.getScore().done(
    (data) ->
      data = null if data.length is 0
      res.render 'index',
        title: conf.title
        auth: user?
        user: userM.getUserInfoFromTwitter(user)
        conf: conf
        score: data
      )
  if user?
    dbUser.getUser(user.id).done(
      (data) ->
        if data.length is 0
          dbUser.save
            id: user.id_str
            name: user.name
            screen_name: user.screen_name
            image: user.profile_image_url
            time_zone: user.time_zone
            lang: user.lang
            ctime: new Date()
            mtime: new Date()
    )
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
