
module.exports = (sequelize, DataTypes) ->

  College = sequelize.define 'College',
    name: DataTypes.STRING
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW

  , classMethods:
  
    associate: (models) ->
      College.hasMany models.Class
