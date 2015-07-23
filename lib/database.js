'use strict';

var Sequelize = require('sequelize');
var config = require('');

var db = function() {
  var sequelize = new Sequelize('database', 'username', 'password');
  return sequelize;
};

module.exports = db();
