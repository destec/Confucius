
module.exports = (sequelize, DataTypes) ->

  Category = sequelize.define 'Category',
    name: DataTypes.STRING
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
