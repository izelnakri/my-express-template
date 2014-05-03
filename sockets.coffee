app = require("./settings")

server = app.listen (3000), () -> 
  console.log('APPLICATION STARTED ON PORT %d'.green, 3000)

io = module.exports = require('socket.io').listen(server, {log: false})

io.configure('development', () ->
  io.enable('browser client minification')
  io.enable('browser client etag')
  io.enable('browser client gzip')
)

