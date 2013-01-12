// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.YelpList = Backbone.Collection.extend({
    initialize: function(models, options) {
      this.term = options.term;
      this.category = options.category;
      this.id = options.id;
      this.title = options.title || options.category || options.term;
      this.on("add", this.onAdd, this);
      return this.on("remove", this.onRemove, this);
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
      return this.filter(function(model) {
        return model.search(term);
      });
    },
    onAdd: function(business) {
      business.addList(this);
      return LOAF.appView.saveApplication();
    },
    onRemove: function(business) {
      business.removeList(this);
      return LOAF.appView.saveApplication();
    },
    fetch: function(controls) {
      var accessor, message, options, parameterMap, parameters,
        _this = this;
      options = {};
      controls = controls ? controls : {};
      controls.page = controls.page ? controls.page : 0;
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
      parameters.push(['location', LOAF.location]);
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
      options.success = function(a, b, c) {
        _this._onResponse(a, b, c);
        if (controls.success) {
          return controls.success(a, b, c);
        }
      };
      options.error = function(a, b, c) {
        if (controls.error) {
          return controls.error;
        }
      };
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
    },
    toJSON: function() {
      var object;
      return object = {
        models: Backbone.Collection.prototype.toJSON.call(this),
        category: this.category,
        term: this.term,
        id: this.id
      };
    }
  });

}).call(this);
