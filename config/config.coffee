path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'confucius'
    port: 3000
    db: 'mysql://cat:123456@localhost/confucius'

  test:
    root: rootPath
    app:
      name: 'confucius'
    port: 3000
    db: 'mysql://localhost/confucius-test'

  production:
    root: rootPath
    app:
      name: 'confucius'
    port: 3000
    db: 'mysql://localhost/confucius-production'

module.exports = config[env]
