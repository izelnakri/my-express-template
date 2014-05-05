express = require "express"
passport = require "passport"
compress = require "compression"
morgan = require "morgan"

app = module.exports = express()

app.engine('ect', require('ect')({ watch: true, root: __dirname + '/views', ext : '.ect' }).render)
app.set('view engine', 'ect') #enables omitting .ect 

app.use(compress({threshhold: 512}))
app.use(express.static(__dirname + "/public", {maxAge: (365*86400000)}))
app.use(morgan("dev"))