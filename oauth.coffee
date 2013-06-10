
everyauth = require('everyauth')
dbUser = require('./mongodb/user')

everyauth.everymodule
  .handleLogout (req, res) ->
    # describe original process after logout.
    # for example, change redirect URL.
    console.log '--- logout ---'
    req.session.destroy()
    res.writeHead(303, {'Location': '/'})
    res.end()

  .moduleErrback (err) ->
    # this process neeeds to avoid error.
    console.log '--- error ---'
    console.log(err)

  .findUserById (req, userId, callback) ->
    req.user = userId
    callback(null, userId)

exports.twitter = () ->
  everyauth.twitter.configure
    consumerKey: 'TqN2L0KkvZ23GLYjUIbcw'
    consumerSecret: 'INUQX9y5ZmAcr19kxIiq6WWlPVzwfugkJbdSvc'
    myHostname: 'http://sharescores.q-x-p.net'
    findOrCreateUser: (session, accessToken, accessTokenSecret, twitterUserData) ->
      promise = this.Promise()
      id = twitterUserData.id_str
      promise.fulfill({id: "twitter:#{id}"})
      #dbUser.getUser(id).done (data) ->
      #  unless data.id?
      #    date = new Date()
      #    data =
      #      id: id
      #      name: twitterUserData.name
      #      screen_name: twitterUserData.screen_name
      #      time_zone: twitterUserData.time_zone
      #      lang: twitterUserData.lang
      #      c_time: date.getTime()
      #    exports.userInfo id, data
      #    dbUser.save data
      #  else
      #    exports.userInfo id, data
      #  return promise
      return promise

    redirectPath: 'http://sharescores.q-x-p.net/'

_userInfo = {}
exports.userInfo = (key, value = null) ->
  return _userInfo[key] ? null unless value
  _userInfo[key] = value
