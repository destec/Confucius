
module.exports = (sequelize, DataTypes) ->

  Record = sequelize.define 'Record',
    name: DataTypes.STRING
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
