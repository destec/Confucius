require('coffee-script/register');

var express = require('express'),
  config = require('./config/config'),
  db = require('./src/models');

var app = express();

require('./config/express')(app, config);

db.sequelize
  .sync()
  .then(function() {
    app.listen(config.port);
  }).catch(function(e) {
    throw new Error(e);
  });
