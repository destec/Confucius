express  = require 'express'
router = express.Router()
_ = require 'lodash'
db = require '../models'
dbUtils = require '../utils/dbUtils'

router.get '/scores', (req, res) ->
  template = 'score/score'
  dbUtils.getPaginationResult 'Score', req.query
  .then (ret) ->
    res.render template, ret

router.post '/scores', (req, res) ->
  template = 'score/score'
  dbUtils.getPaginationResult 'Score', req.body
  .then (ret) ->
    res.render template, ret

router.get '/scores/create', (req, res) ->
  template = 'score/score_dialog'
  ret =
    username: req.session.user.username
  res.render template, ret

router.post '/scores/create', (req, res) ->
  params = _.zip req.body['student.code'].split(','), req.body['student.name'].split(','), req.body['student.className'].split(',')
  # if params[0].length isnt params[1].length isnt params[2].length
  #   ret =
  #     statusCode: '300'
  #     message: '学分记录添加失败，长度不一致'
  #   return res.send ret
  promArr = []
  params.forEach (param) ->
    score =
      code: param[0]
      student: param[1]
      class: param[2]
      type: req.body['type.name']
      score: req.body['type.score']
      TypeId: req.body['type.id']
      teacher: req.body.teacher
    promArr.push db.Score.create score
  Promise.all promArr
  .then (data) ->
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

router.get '/scores/edit', (req, res) ->
  uid = req.query.uid
  db.Score.findById uid
  .then (result) ->
    ret =
      code: result.code
      student: result.student
      class: result.class
      type: result.type
      score: result.score
      TypeId: result.TypeId
      teacher: result.teacher
    res.render 'score/score_edit', ret

module.exports = (app) ->
  app.use '/score', router
