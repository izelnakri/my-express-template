window.Application =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->    
    new Application.Routers.Base()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Application.initialize()

class Application.Routers.Base extends Backbone.Router
  routes: 
    '': 'index'

  index: ->
    console.log("ROUTE - Index action initiated")

