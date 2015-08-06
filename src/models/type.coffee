
module.exports = (sequelize, DataTypes) ->

  Type = sequelize.define 'Type',
    name: DataTypes.STRING
    score: DataTypes.NUMBER
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
