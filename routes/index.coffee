
dbUser = require '../mongodb/user'
userM = require '../model/user'
scoreM = require '../model/score'
conf = require('../conf').getConf()

exports.index = (req, res, params = {}) ->
  user = req.session.auth?.twitter?.user
  console.log user?.screen_name
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

exports.signout = (req, res) ->
  delete req.session.auth
  res.redirect conf.domain
