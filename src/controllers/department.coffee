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

router.get '/classes', (req, res) ->
  template = 'department/class'
  db.Class.findAndCountAll()
  .then (result) ->
    ret =
      classes: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret

module.exports = (app) ->
  app.use '/department', router
