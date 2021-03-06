// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.ListsList = (function() {

    function ListsList(options) {
      options = options ? options : {};
      this.lists = options.lists ? options.lists : [];
    }

    ListsList.prototype.addLists = function(lists) {
      return _.each(lists, this.addList, this);
    };

    ListsList.prototype.addList = function(list) {
      list.id = LOAF.yelpLists.getLists().length + LOAF.customLists.getLists().length;
      return this.lists.push(list);
    };

    ListsList.prototype.removeList = function(list) {
      return this.lists = _.without(this.lists, list);
    };

    ListsList.prototype.getLists = function() {
      return this.lists.slice(0);
    };

    ListsList.prototype.fetchLists = function(onSuccess, onError) {
      var heardBack, hollaBack,
        _this = this;
      heardBack = 0;
      hollaBack = function() {
        heardBack++;
        if (heardBack === _this.lists.length) {
          return onSuccess();
        }
      };
      return _.each(this.lists, function(list) {
        return list.fetch({
          success: hollaBack,
          error: function(c, x, o) {
            return console.log(x);
          }
        });
      });
    };

    ListsList.prototype.where = function(properties) {
      return _.where(this.lists, properties);
    };

    ListsList.prototype.each = function(iterator, context) {
      return _.each(this.lists, iterator, context);
    };

    ListsList.prototype.search = function(term) {
      return _.flatten(_.map(this.lists, function(list) {
        return list.search(term);
      }, true));
    };

    return ListsList;

  })();

}).call(this);
