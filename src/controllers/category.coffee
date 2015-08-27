express  = require 'express'
router = express.Router()
db = require '../models'
dbUtils = require '../utils/dbUtils'

router.get '/categories', (req, res) ->
  template = 'category/category'
  db.Category.findAndCountAll()
  .then (result) ->
    ret =
      categories: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.post '/categories', (req, res) ->
  res.redirect '/category/categories'

router.get '/categories/create', (req, res) ->
  template = 'category/category_dialog'
  res.render template

router.post '/categories/create', (req, res) ->
  params =
    name: req.body.name
    code: req.body.code
  db.Category.create params
  .then (result) ->
    ret =
      statusCode: 200
      message: '大类添加成功'
      navTabId: 'category_page_category'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

router.post '/categories/delete', (req, res) ->
  uid = req.query.uid
  db.Category.findOne
    where:
      id: uid
  .then (category) ->
    category.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: '200'
      message: '大类删除成功'
      rel: ''
      navTabId: 'category_page_category'
    res.status 200
    .send ret

router.get '/types', (req, res) ->
  template = 'category/type'
  db.Type.findAndCountAll()
  .then (result) ->
    ret =
      types: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

router.post '/types', (req, res) ->
  res.redirect '/category/types'

router.get '/types/create', (req, res) ->
  template = 'category/type_dialog'
  db.Category.findAll()
  .then (categories) ->
    ret =
      categories: dbUtils.getDataValues categories
    res.render template, ret

router.post '/types/create', (req, res) ->
  params =
    name: req.body.name
    code: req.body.code
    score: req.body.score
    CategoryId: req.body.category
  console.log params
  db.Type.create params
  .then (result) ->
    ret =
      statusCode: 200
      message: '小类添加成功'
      navTabId: 'category_page_type'
      rel: ''
      callbackType: 'closeCurrent'
    res.send ret

router.post '/types/delete', (req, res) ->
  uid = req.query.uid
  db.Type.findOne
    where:
      id: uid
  .then (typeIns) ->
    typeIns.destroy()
    .then (result) ->
      return result
  .then (result) ->
    ret =
      statusCode: '200'
      message: '小类删除成功'
      rel: ''
      navTabId: 'category_page_type'
    res.status 200
    .send ret

module.exports = (app) ->
  app.use '/category', router
