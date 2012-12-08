// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.SingleListView = LOAF.BreadcrumbView.extend({
    tagName: 'div',
    className: 'bcrumbs-list-view',
    initialize: function(options) {
      this.title = this.collection.title || this.collection.name;
      this.type = options.type;
      this._historyRep = new LOAF.HistoryItem({
        title: this.title,
        view: this
      });
      return this.initHistory(options);
    },
    render: function() {
      var html, listItemViews, obj, template;
      html = "";
      obj = {
        title: this.collection.title || this.collection.name
      };
      html = Mustache.render(LOAF.templates.bcSingleListView, obj);
      this.$el.html(html);
      listItemViews = [];
      template = this.type === "yelp" ? LOAF.templates.bcYelpViewSingle : LOAF.templates.bcListViewSingle;
      this.collection.each(function(business) {
        return listItemViews.push(new LOAF.ListSingleItemView({
          model: business,
          template: template
        }));
      });
      _.each(listItemViews, function(o) {
        o.render();
        return this.$(".bcrumbs-list-view-items").append(o.el);
      });
      this.listItemViews = listItemViews;
      return this.renderHistory();
    }
  });

}).call(this);
