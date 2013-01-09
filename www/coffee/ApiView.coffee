LOAF.ApiView = Backbone.View.extend
  events:
    "click .api-key-save": "onSave"
    "keyup .consumer-key": "verify"
    "keyup .consumer-secret": "verify"
    "keyup .access-token": "verify"
    "keyup .access-token-secret": "verify"

  verify: ->
    if consumerKey.val() and consumerSecret.val() and accessToken.val() and accessTokenSecret.val()
      @$(".api-key-save").removeAttr "disabled"
    else
      @$(".api-key-save").attr "disabled", "true"

  onSave: ->
    consumerKey = @$("consumer-key")
    consumerSecret = @$("consumer-secret")
    accessToken = @$("access-token")
    accessTokenSecret = @$("access-token-secret")
    if consumerKey.val() and consumerSecret.val() and accessToken.val() and accessTokenSecret.val()
      LOAF.auth.consumerKey = consumerKey.val()
      LOAF.auth.consumerSecret = consumerSecret.val()
      LOAF.auth.accessToken = accessToken.val()
      LOAF.auth.accessTokenSecret = accessTokenSecret.val()
