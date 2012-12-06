// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.CustomList = BackBone.Collection.extend({
    initialize: function(models, options) {
      options = options ? options : {};
      this.name = options.name;
      this.isAllCrumbs = options.isAllCrumbs || false;
      return this.id = options.id;
    },
    model: LOAF.Business,
    search: function(term) {
      return this.filter(function(model) {
        return model.search(term);
      });
    },
    toJSON: function() {
      var object;
      return object = {
        models: Backbone.Collection.prototype.toJSON.call(this),
        name: this.name,
        isAllCrumbs: this.isAllCrumbs,
        id: this.id
      };
    }
  });

}).call(this);
