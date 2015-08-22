express  = require 'express'
router = express.Router()
db = require '../models'
dbUtils = require '../utils/dbUtils'

router.get '/colleges', (req, res) ->
  template = 'department/college'
  db.College.findAndCountAll()
  .then (result) ->
    ret =
      colleges: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.post '/colleges', (req, res) ->
  res.redirect '/department/colleges'

router.get '/colleges/create', (req, res) ->
  template = 'department/college_dialog'
  res.render template

router.post '/colleges/create', (req, res) ->
  params =
    name: req.body.name
  db.College.create params
  .then (result) ->
    ret =
      statusCode: 200
      message: '学院添加成功'
      navTabId: 'department_page_college'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

router.post '/colleges/delete', (req, res) ->
  uid = req.query.uid
  db.College.findOne
    where:
      id: uid
  .then (college) ->
    college.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: '200'
      message: '学院删除成功'
      rel: ''
      navTabId: 'department_page_college'
    res.status 200
    .send ret

router.get '/classes', (req, res) ->
  template = 'department/class'
  db.Class.findAndCountAll()
  .then (result) ->
    ret =
      classes: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.post '/classes', (req, res) ->
  res.redirect '/department/classes'

router.get '/classes/create', (req, res) ->
  template = 'department/class_dialog'
  res.render template

router.post '/classes/create', (req, res) ->
  params =
    name: req.body.name
    director: req.body.director
    college: req.body.college
  db.Class.create params
  .then (result) ->
    ret =
      statusCode: 200
      message: '班级添加成功'
      navTabId: 'department_page_class'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

router.post '/classes/delete', (req, res) ->
  uid = req.query.uid
  db.Class.findOne
    where:
      id: uid
  .then (classIns) ->
    classIns.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: '200'
      message: '班级删除成功'
      rel: ''
      navTabId: 'department_page_class'
    res.status 200
    .send ret

module.exports = (app) ->
  app.use '/department', router
