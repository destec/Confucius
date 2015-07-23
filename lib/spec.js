'use strict';
var express = require('express');

module.exports = function spec() {
  return {
    onconfig: function(config, next) {
      // db.config(config.get('databaseConfig'));
      next(null, config);
    }
  };
};
