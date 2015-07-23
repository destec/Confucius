var express = require('express'),
  db = require('../lib/database');

module.exports = function spec() {
  return {
    onconfig: function(config, next) {
      var sequelize = db.config(config.get('databaseConfig'));
      require('../models/user').init(sequelize);
      next(null, config);
    }
  };
};
