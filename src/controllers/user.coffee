express  = require 'express'
router = express.Router()
db = require '../models'

module.exports = (app) ->
  app.use '/user', router

router.get '/admins', (req, res) ->
  template = 'user/admin'
  res.render template

router.get '/teachers', (req, res) ->
  template = 'user/teacher'
  res.render template

router.get '/students', (req, res) ->
  template = 'user/student'
  res.render template
