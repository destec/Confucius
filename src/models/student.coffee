
module.exports = (sequelize, DataTypes) ->

  Student = sequelize.define 'Student',
    name: type: DataTypes.STRING, allowNull: false
    code: type: DataTypes.INTEGER, unique: true, allowNull: false
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW

  , classMethods:

    associate: (models) ->
      Student.belongsTo models.Class
      Student.hasMany models.Score
