express  = require 'express'
router = express.Router()
db = require '../models'
dbUtils = require '../utils/dbUtils'

router.get '/admins', (req, res) ->
  template = 'user/admin'
  db.User.findAndCountAll()
  .then (result) ->
    ret =
      users: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.get '/admins/create', (req, res) ->
  template = 'user/admin_dialog'
  res.render template

router.post '/admins/create', (req, res) ->
  params =
    code: req.body.code
    username: req.body.username
    password: req.body.password
    email: req.body.email
  db.User.create params
  .then (result) ->
    ret =
      statusCode: "200"
      message: "管理员添加成功"
    res.status 200
    .send ret

router.post '/admins/delete', (req, res) ->
  uid = req.query.uid
  db.User.findOne
    where:
      id: uid
  .then (user) ->
    user.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: "200"
      message: "管理员删除成功"
    res.status 200
    .send ret

router.get '/admins/edit', (req, res) ->


router.get '/teachers', (req, res) ->
  template = 'user/teacher'
  res.render template

router.get '/students', (req, res) ->
  template = 'user/student'
  res.render template

module.exports = (app) ->
  app.use '/user', router
