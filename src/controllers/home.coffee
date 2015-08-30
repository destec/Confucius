express  = require 'express'
router = express.Router()
db = require '../models'

module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res) ->
  ret =
    user: req.session.user.username
  res.render 'index', ret

router.get '/login', (req, res) ->
  res.render 'login'

router.post '/login', (req, res) ->
  if req.body.privilege is '0'
    db.Teacher.findOne
      where:
        username: req.body.username
    .then (teacher) ->
      return res.redirect '/login' unless teacher
      req.session.uid = teacher.id
      req.session.user = teacher
      req.session.permissionLev = 0
      req.session.save()
      return res.redirect '/' if teacher?.password is req.body.password
      res.redirect '/login'
  else if req.body.privilege is '1'
    db.User.findOne
      where:
        username: req.body.username
    .then (admin) ->
      return res.redirecr '/login' unless admin
      req.session.uid = admin.id
      req.session.user = admin
      req.session.permissionLev = 1
      req.session.save()
      return res.redirect '/' if admin?.password is req.body.password
      res.redirect '/login'
  else
    res.redirect '/login'

router.get '/logout', (req, res) ->
  req.session = null
  res.redirect '/login'
