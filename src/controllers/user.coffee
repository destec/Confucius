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

router.post '/admins', (req, res) ->
  res.redirect '/user/admins'

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
      statusCode: '200'
      message: '管理员添加成功'
      navTabId: 'user_page_admin'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

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
      rel: ''
      navTabId: 'user_page_admin'
    res.status 200
    .send ret

router.get '/admins/edit', (req, res) ->

router.get '/teachers', (req, res) ->
  template = 'user/teacher'
  db.Teacher.findAndCountAll()
  .then (result) ->
    ret =
      teachers: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.post '/teachers', (req, res) ->
  res.redirect '/user/teachers'

router.get '/teachers/create', (req, res) ->
  template = 'user/admin_dialog'
  res.render template

router.post '/teachers/create', (req, res) ->
  params =
    code: req.body.code
    username: req.body.username
    password: req.body.password
    email: req.body.email
  db.Teacher.create params
  .then (result) ->
    ret =
      statusCode: '200'
      message: '教师添加成功'
      navTabId: 'user_page_teacher'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

router.post '/teachers/delete', (req, res) ->
  uid = req.query.uid
  db.Teacher.findOne
    where:
      id: uid
  .then (teacher) ->
    teacher.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: "200"
      message: "教师删除成功"
      rel: ''
      navTabId: 'user_page_teacher'
    res.status 200
    .send ret

router.get '/students', (req, res) ->
  template = 'user/student'
  res.render template

module.exports = (app) ->
  app.use '/user', router
