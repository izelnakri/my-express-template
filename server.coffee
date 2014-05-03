require "coffee-script"
require "colors"

app = require "./config"
db = require './models'

app.get("/", (req, res) ->
  res.render "example"
)