
module.exports = (sequelize, DataTypes) ->

  Class = sequelize.define 'Class',
    name: DataTypes.STRING
    director: DataTypes.STRING
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW

  , classMethods:

    associate: (models) ->
      Class.belongsTo models.College
