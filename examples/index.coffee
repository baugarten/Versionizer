express = require 'express'
mongoose = require 'mongoose'
versionizer = require '../'

app = express()
app.use require('body-parser')()

mongoose.connect "mongodb://localhost/versionizer_movies_example"

userRoutes = require './routes/users'

app.use "/api", versionizer("users", userRoutes)

if (!module.parent)
    app.listen(3000)

module.exports = app
