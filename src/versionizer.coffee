express = require 'express'

app = express()

ALLOWED_METHODS = ['get', 'post', 'put', 'delete']

validate = (route) ->
  errors = []
  if "method" not of route
    errors.push("Doesn't specify method.")
  else if route.method not in ALLOWED_METHODS
    errors.push("Unrecognized method #{route.method}.")

  unless route.v
    errors.push("Doesn't specify version.")

  unless route.handler
    errors.push("Doesn't specify function handler.")

  errors


module.exports = (resource, routes) ->
  handlers = {}
  for meth in ALLOWED_METHODS
    handlers[meth] = {}

  for route in routes
    errors = validate(route)
    if errors.length > 0
      console.error.apply(console, ["Failed adding route #{route}"].concat(errors))
      continue

    uri = "/v:version/#{resource}#{route.uri or ""}"
    unless uri of handlers[route.method]
      handlers[route.method][uri] = {}
    handlers[route.method][uri][route.v] = route.handler
    app[route.method] uri, (req, res, next) ->
      currentVersion = req.params.version
      versions = handlers[req.method.toLowerCase()][req.route.path]
      while (currentVersion > 0)
        if currentVersion of versions
          versions[currentVersion].apply(@, [req, res, next])
        currentVersion -= 1

  app

