
exports.authCheck = (req, res, next) ->
  unless req.path in ['/login', '/logout', '/themes/css/login.css', '/themes/default/images/login_banner.jpg']
    if req.session and req.session isnt {} and req.session.uid
      next()
    else
      res.redirect '/login'
  else
    next()
