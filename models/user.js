var Sequelize = require('sequelize');

var sequelize;

module.exports.init = function(sequelizeIns) {
  sequelize = sequelizeIns;
};

module.exports.UserModel = function() {
  return sequelize.define('User', {
    username: Sequelize.STRING,
    password: Sequelize.STRING,
    phone: Sequelize.STRING
  });
};
