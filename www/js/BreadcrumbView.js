// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.BreadcrumbView = Backbone.View.extend({
    initHistory: function(options) {
      if (!options) {
        options = {};
      }
      return this.history = options.history ? options.history : [];
    },
    renderHistory: function() {
      var list, templateValues;
      templateValues = {
        historyItems: this.history,
        currentTitle: this.title
      };
      list = Mustache.render($(".template.history-list").html(), templateValues);
      this.$(".bcrumbs-path").html(list);
      return this.$(".history-link").click(this._onHistoryClick);
    },
    _onHistoryClick: function(e) {
      var viewToShow;
      e.preventDefault();
      this.$el.hide();
      viewToShow = this.history[e.currentTarget.dataset.id].view;
      return viewToShow.show();
    }
  });

}).call(this);
