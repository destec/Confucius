var UserModel = require('../models/index').UserModel;

module.exports = function(router) {
  router.get('/', function(req, res) {
    UserModel.findOne({
      where: {
        username: 'admin'
      },
      raw: true
    }).then(function(user) {
      console.log(user);
      res.send('<code><pre>' + JSON.stringify(user, null, 2) +
        '</pre></code>');
    });

  });
};
