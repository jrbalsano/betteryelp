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

      @$(".api-key-save").html "Verifying..."
      @$(".api-key-save").attr "disabled", "true"

      #Test out the provided API information
      accessor =
        consumerSecret: LOAF.auth.consumerSecret,
        tokenSecret: LOAF.auth.accessTokenSecret
      parameters = []
      parameters.push ['callback', 'cb']
      parameters.push ['oauth_consumer_key', LOAF.auth.consumerKey]
      parameters.push ['oauth_consumer_secret', LOAF.auth.consumerSecret]
      parameters.push ['oauth_token', LOAF.auth.accessToken]
      parameters.push ['oauth_signature_method', 'HMAC-SHA1']
      parameters.push ['location', "New York City"]
      parameters.push ['term', 'test']
      message =
        'action': 'http://api.yelp.com/v2/search?'
        'method': 'GET'
        'parameters': parameters
      OAuth.setTimestampAndNonce message
      OAuth.SignatureMethod.sign message, accessor
      parameterMap = OAuth.getParameterMap message.parameters
      parameterMap.oauth_signature = OAuth.percentEncode parameterMap.oauth_signature
      $.ajax
        url: message.action
        data: parameterMap
        cache: true
        dataType: 'jsonp'
        crossDomain: true
        success: (a, b, c) =>
          console.log "done"
          @$el.hide()
          @callback.apply @cbContext, @cbParams
        error: (a, b, c) =>
          console.log "fail"
          @$el.html "<h2>Uh-oh</h2>Looks like there was a problem with your API key. Either there are too many requests on it today or its been copied over incorrectly. Please refresh the page and try again."
        timeout: 10000
        context: @
