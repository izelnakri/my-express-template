app = require "./settings"
db = require "./models"

db.sequelize.sync().complete (err) ->
  throw err if err
  server = app.listen (process.env.PORT || 8000), () -> 
    console.log('APPLICATION STARTED ON PORT %d'.green, process.env.PORT || 8000)

  io = module.exports = require('socket.io').listen(server, {log: false})
  #add production options, add more configuration
  io.configure('development', () ->
    io.enable('browser client minification')
    io.enable('browser client etag')
    io.enable('browser client gzip')
  )
)
