// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.YelpList = Backbone.Collection.extend({
    initialize: function(models, options) {
      this.term = options.term;
      return this.category = options.category;
    },
    model: LOAF.Business,
    url: 'http://api.yelp.com/v2/search?',
    type: function() {
      if (this.category) {
        "category";

      }
      return "term";
    },
    search: function(term) {
      return this.models.filter(function(model) {
        return model.search(term);
      });
    },
    fetch: function(controls) {
      var accessor, message, options, parameterMap, parameters;
      options = {};
      accessor = {
        consumerSecret: LOAF.auth.consumerSecret,
        tokenSecret: LOAF.auth.accessTokenSecret
      };
      parameters = [];
      parameters.push(['callback', 'cb']);
      parameters.push(['oauth_consumer_key', LOAF.auth.consumerKey]);
      parameters.push(['oauth_consumer_secret', LOAF.auth.consumerSecret]);
      parameters.push(['oauth_token', LOAF.auth.accessToken]);
      parameters.push(['oauth_signature_method', 'HMAC-SHA1']);
      parameters.push(['location', "New York City"]);
      if (this.term) {
        parameters.push(['term', this.term]);
      }
      if (this.category) {
        parameters.push(['category_filter', this.category]);
      }
      if (controls && controls.page) {
        parameters.push(['offset', (controls.page - 1) * 20]);
      }
      message = {
        'action': this.url,
        'method': 'GET',
        'parameters': parameters
      };
      OAuth.setTimestampAndNonce(message);
      OAuth.SignatureMethod.sign(message, accessor);
      parameterMap = OAuth.getParameterMap(message.parameters);
      parameterMap.oauth_signature = OAuth.percentEncode(parameterMap.oauth_signature);
      options.url = this.url;
      options.data = parameterMap;
      options.cache = true;
      options.dataType = 'jsonp';
      options.success = this._onResponse;
      options.context = this;
      return $.ajax(options);
    },
    _onResponse: function(data, textStats, xhr) {
      var _this = this;
      return _.each(data.businesses, function(business) {
        var busModel, existing_business;
        if (existing_business = _this.get(business.id)) {
          return existing_business.set(business);
        } else {
          busModel = new LOAF.Business(business);
          return _this.add(busModel);
        }
      });
    }
  });

}).call(this);
