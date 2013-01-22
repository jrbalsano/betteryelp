// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.OnboardView = Backbone.View.extend({
    initialize: function(options) {
      this.callback = options.callback;
      this.cbContext = options.cbContext;
      this.cbParams = options.cbParams;
      return this.categories = [];
    },
    events: {
      "click .collapsable-list-toggle": "onToggle",
      "change input:checkbox": "onChecking",
      "keyup .user-location": "onKeyUp",
      "click .save-categories": "onSave"
    },
    onKeyUp: function(e) {
      if (this.$(".user-location").val()) {
        return this.$(".save-categories").removeAttr("disabled");
      } else {
        return this.$(".save-categories").attr("disabled", "true");
      }
    },
    onChecking: function(e) {
      if (e.srcElement.checked) {
        return this.categories.push({
          category: e.srcElement.value,
          title: e.srcElement.parentElement.textContent.replace(/\s*([A-z ]*)\s*/, "$1")
        });
      } else {
        return this.categories = _(this.categories).without(_(this.categories).find(function(el) {
          return e.srcElement.value === el.category;
        }));
      }
    },
    onToggle: function(e) {
      e.preventDefault();
      $(e.srcElement).parent().children("ul").toggle("slow");
      switch ($(e.srcElement).html()) {
        case "(show more)":
          return $(e.srcElement).html("(show less)");
        case "(show less)":
          return $(e.srcElement).html("(show more)");
      }
    },
    onSave: function(e) {
      e.preventDefault();
      this.$(".save-categories").attr("disabled", "true");
      if (this.$(".user-location").val()) {
        LOAF.categories = this.categories;
        LOAF.location = this.$(".user-location").val();
        this.$el.hide();
        return this.callback.apply(this.cbContext, this.cbParams);
      }
    },
    render: function() {
      return this.$("ul.yelp-categories-list").find("ul").hide();
    }
  });

}).call(this);
