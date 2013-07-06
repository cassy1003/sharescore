
express = require('express')
http = require('http')
path = require('path')
everyauth = require("everyauth")

#socket = require("./socket")
routes = require('./routes')
post = require('./routes/post')
oauth = require("./oauth")
conf = require("./conf").getConf()

mongodb = require('./mongodb')
mongodb.database()

compile = require("./compile")
compile.compileCore()
compile.compileWork()

oauth.twitter()

app = express()
app.configure () ->
  app.set 'port', process.env.PORT || conf.port
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser {uploadDir: './tmp'}
  app.use express.cookieParser 'secret', 'secret-here' # session
  app.use express.session {key: 'sess_id', secret: 'secret-here'} # session
  app.use express.methodOverride()
  app.use everyauth.middleware(app)
  app.use app.router
  app.use express.static(path.join(__dirname, 'public'))

app.configure 'development', () ->
  app.use(express.errorHandler())

app.get '/', routes.index
app.get '/signout', routes.signout

app.post '/upload', post.upload

app.locals (req, res) ->
  app.locals.session = req.session

server = http.createServer(app)
server.listen app.get('port'), () ->
  console.log("Express server listening on port " + app.get('port'))

#socket.connect server

dbWhisper = require('./mongodb/whisper')
dbWhisper.connect()
dbUser = require('./mongodb/user')
dbUser.connect()
