
module.exports = (sequelize, DataTypes) ->

  Score = sequelize.define 'Score',
    type: DataTypes.STRING
    studentCode: DataTypes.STRING
    studentName: DataTypes.STRING
    score: DataTypes.INTEGER
    class: DataTypes.STRING
    teacher: DataTypes.STRING
    description: DataTypes.STRING
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW

  , classMethods:

    associate: (models) ->
      Score.belongsTo models.Student
      Score.belongsTo models.Type
