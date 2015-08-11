express  = require 'express'
router = express.Router()
db = require '../models'
dbUtils = require '../utils/dbUtils'

module.exports = (app) ->
  app.use '/department', router

router.get '/college', (req, res) ->
  template = 'department/college'
  db.College.findAndCountAll()
  .then (result) ->
    ret =
      colleges: dbUtils.getDataValues result.rows
      count: result.count
    res.render template, ret
