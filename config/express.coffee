express = require 'express'
glob = require 'glob'
path = require 'path'

favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
cookieSession = require 'cookie-session'
bodyParser = require 'body-parser'
compress = require 'compression'
methodOverride = require 'method-override'
exphbs  = require 'express-handlebars'

module.exports = (app, config) ->
  app.engine '.hbs', exphbs(
    extname: '.hbs'
    # layoutsDir: config.root + '/src/views/layouts/'
    # defaultLayout: 'index'
  )
  app.set 'views', config.root + '/src/views'
  app.set 'view engine', '.hbs'

  env = process.env.NODE_ENV || 'development'
  app.locals.ENV = env
  app.locals.ENV_DEVELOPMENT = env == 'development'

  # app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use logger 'dev'
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use cookieSession(
    secret: 'catlab@jxxsxy.com'
    keys: ['user']
  )
  app.use require('../src/middlewares/auth').authCheck
  app.use compress()
  app.use express.static('public')
  app.use methodOverride()

  controllers = glob.sync config.root + '/src/controllers/**/*.coffee'
  controllers.forEach (controller) ->
    require(controller)(app)

  # catch 404 and forward to error handler
  # app.use (req, res, next) ->
  #   err = new Error 'Not Found'
  #   err.status = 404
  #   next err

  # error handlers

  # development error handler
  # will print stacktrace

  # if app.get('env') == 'development'
  #   app.use (err, req, res, next) ->
  #     res.status err.status || 500
  #     res.render 'error',
  #       message: err.message
  #       error: err
  #       title: 'error'
  #
  # # production error handler
  # # no stacktraces leaked to user
  # app.use (err, req, res, next) ->
  #   res.status err.status || 500
  #   res.render 'error',
  #     message: err.message
  #     error: {}
  #     title: 'error'
