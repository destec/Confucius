express  = require 'express'
router = express.Router()
db = require '../models'
dbUtils = require '../utils/dbUtils'

router.get '/scores', (req, res) ->
  template = 'score/score'
  db.Score.findAndCountAll()
  .then (result) ->
    ret =
      scores: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.post '/scores', (req, res) ->
  res.redirect '/score/scores'

router.get '/scores/create', (req, res) ->
  template = 'score/score_dialog'
  res.render template

router.post '/scores/create', (req, res) ->
  params =
    code: req.body['student.code']
    student: req.body['student.name']
    class: req.body['student.className']
    type: req.body['type.name']
    score: req.body['type.score']
    teacher: 'Cat'
  db.Score.create params
  .then (result) ->
    ret =
      statusCode: '200'
      message: '学分记录添加成功'
      navTabId: 'score'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

router.post '/scores/delete', (req, res) ->
  uid = req.query.uid
  db.Score.findOne
    where:
      id: uid
  .then (score) ->
    score.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: '200'
      message: '学分记录删除成功'
      rel: ''
      navTabId: 'score'
    res.status 200
    .send ret

router.get '/admins/edit', (req, res) ->

module.exports = (app) ->
  app.use '/score', router
