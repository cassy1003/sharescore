
routes = require './index'
scoreM = require '../model/score'

exports.upload = (req, res) ->
  info =
    text: req.body.upload_text
    size: req.files.upload_file.size
    path: req.files.upload_file.path
    name: req.files.upload_file.name
    user: req.session.auth?.twitter?.user

  scoreM.saveUploadFile(req).done(
    res.redirect '/'
  )
 # target_path = "./public/score/#{path.basename(info.path)}_#{info.name}"
 # fs.rename info.path, target_path, (err) ->
 #   if err then throw err
 #   fs.unlink info.path, () ->
 #     if err then throw err
 #     #routes.index req, res, {message: 'hoge'}
 #     res.redirect '/', {message: 'hoge'}
