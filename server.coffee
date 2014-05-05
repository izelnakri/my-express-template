require "coffee-script"
require "colors"

app = require "./settings"
io = require "./sockets"
db = require "./models"

app.get("/", (req, res) ->
  res.render "example"
)

#controllers would show it like this
# app.get '/', home.index 