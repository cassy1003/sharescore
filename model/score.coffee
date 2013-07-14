
fs   = require 'fs'
path = require 'path'
$    = require 'jquery-deferred'
commonM = require './common'
dbScore = require("../mongodb/score")

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
    size: filesize
    filename: filename
    savename: savename
    user_id: user.id_str
    screen_name: user.screen_name

  $.Deferred (d) ->
    fs.rename filepath, savepath, (err) ->
      unless err
        fs.unlink filepath, () ->
          console.log info
          dbScore.save info
          d.resolve()
      else
        d.reject()

exports.getScore = () ->
  $.Deferred (d) ->
    dbScore.find
      option:
        limit: 3
    .done(
      (data) ->
        scores = []
        for v in data
          scores.push
            date: commonM.getDate v.ctime
            user_id: v.user_id
            screen_name: v.screen_name
            filename: v.filename
            savename: v.savename
            text: v.text
            size: v.size
        d.resolve scores
    )
