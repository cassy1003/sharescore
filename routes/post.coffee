
scoreM = require '../model/score'

exports.upload = (req, res) ->
  scoreM.saveUploadFile(req).done(
    res.redirect '/'
  )
