var Sequelize = require('sequelize');

var db = function() {
  return {
    config: function(conf) {
      var sequelize = new Sequelize(conf.database, conf.username,
        conf.password);
      return sequelize;
    }
  };
};

module.exports = db();
