express  = require 'express'
router = express.Router()
Promise = require 'bluebird'
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
  template = 'user/admin'
  db.User.findAll
    where:
      realname:
        $like: "%#{req.body.realname}%"
  .then (result) ->
    ret =
      users: dbUtils.getDataValues result
      count: result.length
    res.render template, ret

router.get '/admins/create', (req, res) ->
  template = 'user/admin_dialog'
  res.render template

router.post '/admins/create', (req, res) ->
  params =
    code: req.body.code
    username: req.body.username
    realname: req.body.realname
    password: req.body.password
    email: req.body.email
    phone: req.body.phone
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
      statusCode: '200'
      message: '管理员删除成功'
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
  template = 'user/teacher_dialog'
  db.College.findAll()
  .then (result) ->
    colleges = dbUtils.getDataValues result
    console.log colleges
    res.render template, colleges

router.post '/teachers/create', (req, res) ->
  params =
    code: req.body.code
    username: req.body.username
    realname: req.body.realname
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
  db.Student.findAndCountAll()
  .then (result) ->
    ret =
      students: dbUtils.getDataValues result.rows
      count: result.count
  .then (result) ->
    Promise.map result.students, (student) ->
      db.Class.findById student.ClassId
      .then (classIns) ->
        student.className = classIns.name
        return student
    .then (students) ->
      result.students = students
      return result
  .then (ret) ->
    res.render template, ret

router.post '/students', (req, res) ->
  template = 'user/student'
  db.Student.findAll
    where:
      name:
        $like: "%#{req.body.name}%"
  .then (result) ->
    ret =
      students: dbUtils.getDataValues result
      count: result.length
  .then (result) ->
    Promise.map result.students, (student) ->
      db.Class.findById student.ClassId
      .then (classIns) ->
        student.className = classIns.name
        return student
    .then (students) ->
      result.students = students
      return result
  .then (ret) ->
    res.render template, ret

router.get '/students/lookup', (req, res) ->
  template = 'user/student_search_dialog'
  db.Student.findAndCountAll()
  .then (result) ->
    ret =
      students: dbUtils.getDataValues result.rows
      count: result.count
  .then (result) ->
    Promise.map result.students, (student) ->
      db.Class.findById student.ClassId
      .then (classIns) ->
        student.className = classIns.name
        return student
    .then (students) ->
      result.students = students
      return result
  .then (ret) ->
    res.render template, ret

router.post '/students/lookup', (req, res) ->
  console.log req.body

router.get '/students/create', (req, res) ->
  template = 'user/student_dialog'
  db.Class.findAll()
  .then (classes) ->
    ret =
      classes: dbUtils.getDataValues classes
    res.render template, ret

router.post '/students/create', (req, res) ->
  params =
    code: req.body.code
    name: req.body.name
    ClassId: req.body.class
  db.Student.create params
  .then (result) ->
    ret =
      statusCode: '200'
      message: '学生添加成功'
      navTabId: 'user_page_student'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

router.post '/students/delete', (req, res) ->
  uid = req.query.uid
  db.Student.findOne
    where:
      id: uid
  .then (student) ->
    student.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: "200"
      message: "学生删除成功"
      rel: ''
      navTabId: 'user_page_student'
    res.status 200
    .send ret

module.exports = (app) ->
  app.use '/user', router
