
moment = require 'moment'
db = require '../models'

dbutils =

  formatCommonResult: (raws) ->
    if Array.isArray raws
      result = []
      moment.locale 'zh-cn'
      raws.forEach (line) ->
        if line.dataValues.createdAt?
          line.dataValues.createdAt = moment(line.dataValues.createdAt).format('LLLL')
        if line.dataValues.updatedAt?
          line.dataValues.updatedAt = moment(line.dataValues.updatedAt).format('LLLL')
        result.push line.dataValues
      return result

  getDataValues: (raws) ->
    if Array.isArray raws
      result = []
      moment.locale 'zh-cn'
      raws.forEach (line) ->
        if line.dataValues.createdAt?
          line.dataValues.createdAt = moment(line.dataValues.createdAt).format('LLLL')
        if line.dataValues.updatedAt?
          line.dataValues.updatedAt = moment(line.dataValues.updatedAt).format('LLLL')
        result.push line.dataValues
      return result

  getPaginationResult: (CollectionName, params) ->
    pageId = if params?.pageNum? then parseInt params.pageNum else 1
    numPerPage = if params?.numPerPage? then parseInt params.numPerPage else 19
    options =
      limit: numPerPage
      offset: (pageId - 1) * numPerPage
    self = this
    db[CollectionName].findAndCountAll options
    .then (result) ->
      ret =
        scores: self.formatCommonResult result.rows
        count: result.rows.length
        totalCount: result.count
        currentPage: pageId

module.exports = dbutils
