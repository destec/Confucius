
moment = require 'moment'

dbutils =

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

module.exports = dbutils
