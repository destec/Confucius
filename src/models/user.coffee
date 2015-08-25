
module.exports = (sequelize, DataTypes) ->

  User = sequelize.define 'User',
    username: type: DataTypes.STRING, unique: true, allowNull: false
    password: type: DataTypes.STRING, allowNull: false
    realname: DataTypes.STRING
    email: DataTypes.STRING
    phone: DataTypes.STRING
    code: type: DataTypes.INTEGER, unique: true, allowNull: false
    createdAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
    updatedAt:
      type: DataTypes.DATE
      defaultValue: DataTypes.NOW
