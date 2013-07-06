
fs   = require 'fs'
path = require 'path'
$    = require 'jquery-deferred'
commonM = require './common'

_scoreDir = './public/score'

_score = null

exports.saveUploadFile = (req) ->
  text = req.body.upload_text
  filesize = req.files.upload_file.size
  filepath = req.files.upload_file.path
  filename = req.files.upload_file.name
  savename = "#{path.basename(filepath)}_#{filename}"
  savepath = "#{_scoreDir}/#{savename}"
  user = req.session.auth?.twitter?.user
  info =
    text: text
    filesize: filesize
    filename: filename
    savename: savename
    user: user

  $.Deferred (d) ->
    fs.rename filepath, savepath, (err) ->
      unless err
        fs.unlink filepath, () ->
          setScore(info)
          d.resolve()
      else
        d.reject()

setScore = (info) ->
  _score = [] unless _score
  _score.push(
    timestamp: new Date() / 1
    date: commonM.getDate()
    info: info
  )

exports.getScore = () ->
  return _score
