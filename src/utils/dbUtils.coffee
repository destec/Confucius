
dbutils =

  getDataValues: (raws) ->
    if Array.isArray raws
      result = []
      raws.forEach (line) ->
        result.push line.dataValues
      return result

module.exports = dbutils
