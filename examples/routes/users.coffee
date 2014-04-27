
module.exports = [
    method: "get"
    v: 1
    handler: (req, res, next) ->
      res.send("All Versions")
  ,
    uri: "/:id"
    method: "get"
    v: 1
    handler: (req, res, next) ->
      res.send("All Versions")
  ,
    uri: "/:id"
    method: "delete"
    v: 1
    handler: (req, res, next) ->
      res.send("All Versions")
  ,
    method: "post"
    v: 1
    handler: (req, res, next) ->
      res.send(404,"This version is deprecated. Please update your API client")
  ,
    method: "post"
    v: 2
    handler: (req, res, next) ->
      # Validate invite code
      res.send("Validated invite code for V2 and V3")
  ,
    uri: "/:id"
    method: "put"
    v: 1
    handler: (req, res, next) ->
      res.send("Custom Validation for API Version 1")
  ,
    uri: "/:id"
    method: "put"
    v: 2
    handler: (req, res, next) ->
      res.send("Custom validation for API Version 2")
  ,
    uri: "/:id"
    method: "put"
    v: 3
    handler: (req, res, next) ->
      res.send("Custom validation for API Version 3")
]
