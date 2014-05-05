fs = require("fs")
path = require("path")
Sequelize = require("sequelize")

#ADD Database name
sequelize = new Sequelize(process.env.DATABASE_URL || "testapp", "root", null, {dialect: "postgres",port: 5432})

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