versionizer = require '../index'
helpers = require './helpers'
mocha = require 'mocha'
request = require 'supertest'
should = require 'should'
sinon = require 'sinon'
app = require '../examples'

noop = (-> )

describe "Versionizer", ->
  describe "error handling", ->
    it "should error when the method is missing", ->
      helpers.assertErrorsWithRoute(helpers.routeWithMethod(), "Doesn't specify method.")

    it "should error when the method is invalid", ->
      INVALID_METHODS = ["hello", "posted", "puts", "gwt"]
      for method in INVALID_METHODS
        helpers.assertErrorsWithRoute(helpers.routeWithMethod(method), "Unrecognized method #{method}.")

    it "should error when the version is missing", ->
      helpers.assertErrorsWithRoute(helpers.routeWithVersion(), "Doesn't specify version.")

    it "should error when the handler is missing", ->
      helpers.assertErrorsWithRoute(helpers.routeWithHandler(), "Doesn't specify function handler.")

  describe "exposing endpoints", ->
    for i in [1..10]
      it "should not 404 on version #{i} get list endpoint", (done) ->
        request(app)
          .get("/api/v#{i}/users")
          .expect(200)
          .end (err, res) ->
            res.text.should.equal("All Versions")
            done()
    it "should select the specified version POSTv1", (done) ->
      request(app)
        .post("/api/v1/users")
        .expect(404)
        .end (err, res) ->
          res.text.should.equal("This version is deprecated. Please update your API client")
          done()

    it "should select the specified version POSTv2", (done) ->
      request(app)
        .post("/api/v2/users")
        .expect(200)
        .end (err, res) ->
          res.text.should.equal("Validated invite code for V2 and V3")
          done()

    it "should select the next highest available version POSTv10", (done) ->
      request(app)
        .post("/api/v10/users")
        .expect(200)
        .end (err, res) ->
          res.text.should.equal("Validated invite code for V2 and V3")
          done()

    it "should select the available version PUTv10", (done) ->
      request(app)
        .put("/api/v10/users/1")
        .expect(200)
        .end (err, res) ->
          res.text.should.equal("Custom validation for API Version 3")
          done()

    it "should ignore the query string when selecting the version to use", (done) ->
      request(app)
        .get("/api/v5/users/1?version=1&v=1&hello=world")
        .end (err, res) ->
          res.text.should.equal("All Versions")
          done()
