fs = require("fs")
path = require("path")
Sequelize = require("sequelize")

if (process.env.DATABASE_URL) 
  #the application is executed on Heroku ... use the postgres database
  match = process.env.DATABASE_URL.match(/postgres:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/)
  sequelize = new Sequelize(match[5], match[1], match[2], {
    dialect:  'postgres',
    protocol: 'postgres',
    port:     match[4],
    host:     match[3],
    logging:  true #or make it false
  })
else 
  #the application is executed on the local machine change "izelnakri" to yours!
  sequelize = new Sequelize("testapp", "izelnakri", null, {dialect: "postgres"})

## mounting models & associations
db = {}
fs.readdirSync(__dirname).filter((file) ->
  (file.indexOf(".") isnt 0) and (file isnt "index.coffee")
).forEach (file) ->
  model = sequelize.import(path.join(__dirname, file))
  db[model.name] = model
Object.keys(db).forEach (modelName) ->
  db[modelName].options.associate db  if db[modelName].options.hasOwnProperty("associate")

module.exports = Sequelize.Utils._.extend(
  sequelize: sequelize
  Sequelize: Sequelize
, db)