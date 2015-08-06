express  = require 'express'
router = express.Router()
db = require '../models'
dbUtils = require '../utils/dbUtils'

module.exports = (app) ->
  app.use '/user', router

router.get '/admins', (req, res) ->
  template = 'user/admin'
  db.User.findAndCountAll()
  .then (result) ->
    ret =
      users: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.get '/teachers', (req, res) ->
  template = 'user/teacher'
  res.render template

router.get '/students', (req, res) ->
  template = 'user/student'
  res.render template
