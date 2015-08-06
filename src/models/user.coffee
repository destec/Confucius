
module.exports = (sequelize, DataTypes) ->

  User = sequelize.define 'User',
    username: DataTypes.STRING
    password: DataTypes.STRING
    realname: DataTypes.STRING
    email: DataTypes.STRING
    code: DataTypes.STRING
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
