versionizer = require '../'
sinon = require 'sinon'
should = require 'should'


baseRoute = ->
  {
      uri: "/hello"
      method: "get"
      v: 1
      handler: module.exports.noop
  }

module.exports.routeWithField = (field) ->
  (value) ->
    route = baseRoute()
    if arguments.length == 0
      delete route[field]
    else
      route[field] = value
    route

module.exports.noop = (-> )

module.exports.assertErrorsWithRoute = (route, errors...) ->
  console.error = sinon.spy()
  app = versionizer "users", [route]
  console.error.calledOnce.should.be.true
  console.error.calledWith.apply(console.error, ["Failed adding route #{route}"].concat(errors)).should.be.true

module.exports.routeWithMethod = module.exports.routeWithField("method")
module.exports.routeWithVersion = module.exports.routeWithField("v")
module.exports.routeWithHandler = module.exports.routeWithField("handler")


