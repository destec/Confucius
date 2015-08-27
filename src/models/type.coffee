
module.exports = (sequelize, DataTypes) ->

  Type = sequelize.define 'Type',
    code: type: DataTypes.INTEGER, unique: true, allowNull: false
    name: DataTypes.STRING
    score: DataTypes.INTEGER
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW

  , classMethods:

    associate: (models) ->
      Type.belongsTo models.Category
