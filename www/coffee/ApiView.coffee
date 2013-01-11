LOAF.ApiView = Backbone.View.extend
  initialize: (options) ->
    @callback = options.callback
    @cbContext = options.cbContext
    @cbParams = options.cbParams

  events:
    "click .api-key-save": "onSave"
    "keyup .consumer-key": "verify"
    "keyup .consumer-secret": "verify"
    "keyup .access-token": "verify"
    "keyup .access-token-secret": "verify"

  verify: ->
    consumerKey = @$(".consumer-key")
    consumerSecret = @$(".consumer-secret")
    accessToken = @$(".access-token")
    accessTokenSecret = @$(".access-token-secret")
    if consumerKey.val() and consumerSecret.val() and accessToken.val() and accessTokenSecret.val()
      @$(".api-key-save").removeAttr "disabled"
    else
      @$(".api-key-save").attr "disabled", "true"

  onSave: (e) ->
    e.preventDefault()
    consumerKey = @$(".consumer-key")
    consumerSecret = @$(".consumer-secret")
    accessToken = @$(".access-token")
    accessTokenSecret = @$(".access-token-secret")
    if consumerKey.val() and consumerSecret.val() and accessToken.val() and accessTokenSecret.val()
      LOAF.auth.consumerKey = consumerKey.val()
      LOAF.auth.consumerSecret = consumerSecret.val()
      LOAF.auth.accessToken = accessToken.val()
      LOAF.auth.accessTokenSecret = accessTokenSecret.val()
      @$el.hide()
      @callback.apply @cbContext, @cbParams
