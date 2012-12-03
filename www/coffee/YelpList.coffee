LOAF.YelpList = Backbone.Collection.extend
  model: LOAF.Business
  url: 'http://api.yelp.com/v2/search?'
  fetch: (options) ->
    options = {} unless options
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

    message = 
      'action': @url,
      'method': 'GET',
      'parameters': parameters
    OAuth.setTimestampAndNonce message
    OAuth.SignatureMethod.sign message, accessor

    parameterMap = OAuth.getParameterMap message.parameters
    parameterMap.oauth_signature = OAuth.percentEncode parameterMap.oauth_signature

    options.url = @url
    options.data = parameterMap
    options.cache = true
    options.dataType = 'jsonp'
    options.jsonpCallback = 'cb'
    options.success = @_onResponse
    options.context = @

    $.ajax options

  _onResponse: (data, textStats, xhr) ->
    debugger
    _.each data.businesses, (business) =>
      unless @get(business.id) # create a new model if one does not exist
        busModel = new LOAF.Business(business)
        @add(busModel)

