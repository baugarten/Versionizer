Versionizer
===========

### Use Case

Versioning Node APIs can be annoying... especially when you have many clients and want to rapidly iterate on the API without breaking real customers (without having a ton of route registration logic).

Versionizer lets you version the important changes from version to version and it takes care of finding the correct version to use on a given request and endpoint.

This is especially important when you cannot control when your API consumers update (browser extensions, mobile apps, etc). Now you can rapidly develop and not worry about making breaking changes!


### Usage

Lets say we release v1 of an API and then want to introduce a small feature when creating new users. Rather than having to register every route handler at /v1 and /v2, we could do something like

```js
app.use "/api", versionizer("users", [{
  method: "post",
  v: 1,
  handler: // old logic
}, {
  method: "post",
  v: 2,
  handler: // new logic
}, {
  uri: "/:id"
  method: "get",
  v: 1,
  handler: // old API 
}]
```

The object should look like 
```js
{
  uri: "/path/to/resource",
  method: "HTTP Verb",
  v: 2,
  handler: function(req, res, next) {
    res.send("Blah!");
  }
}
```

If no uri is specified, "" is used

When a client posts to /api/v1/users, they will get the old logic  
When a client posts to /api/v2/users, they will get the new logic  
When a client gets /api/v1/users/1 or /api/v2/users/1 or /api/v1000/users/1, they will get the old API  

Shazam!
