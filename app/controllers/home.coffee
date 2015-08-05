express  = require 'express'
router = express.Router()
db = require '../models'

module.exports = (app) ->
  app.use '/', router

router.get '/dwz.frag.xml', (req, res) ->
  res.redirect '/components/dwz.frag.xml'
