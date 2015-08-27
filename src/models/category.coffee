
module.exports = (sequelize, DataTypes) ->

  Category = sequelize.define 'Category',
    name: DataTypes.STRING
    code:
      type: DataTypes.INTEGER
      unique: true
      allowNull: false
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW

  , classMethods:

    associate: (models) ->
      Category.hasMany models.Type
