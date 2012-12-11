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
    events: {
      "click .bcrumbs-single-list-view-link a": "onShowItem"
    },
    onShowItem: function(e) {
      e.preventDefault();
      if (LOAF.singleView != null) {
        LOAF.singleView.undelegateEvents();
      }
      LOAF.singleView = new LOAF.SingleItemView({
        el: $(".bcrumbs-single-view"),
        model: this.collection.get(e.srcElement.dataset.id),
        caller: this._historyRep,
        collection: this.collection,
        history: this.history.slice(0)
      });
      LOAF.singleView.render();
      this.$el.hide();
      return LOAF.singleView.$el.show();
    },
    postRender: function() {
      var arr, container_path, el, mode, on_;
      this.$('.bcrumbs-single-list-view-link > a').each(function(i) {
        if (this.text.length > 20) {
          return $(this).text($(this).text().substring(0, 20) + "...");
        }
      });
      on_ = false;
      mode = "off";
      container_path = "img/iphone_switch_container_off.png";
      mode = (on_ ? "on" : "off");
      container_path = (on_ ? "img/iphone_switch_container_off.png" : "img/iphone_switch_container_on.png");
      el = $(".edit-toggle");
      el.iphoneSwitch(mode, (function() {
        console.log("on?");
        return on_ = true;
      }), (function() {
        console.log("off?");
        return on_ = false;
      }), {
        switch_on_container_path: container_path
      });
      arr = [];
      return this.$('.bcrumbs-single-list-item').each(function(i) {
        var high;
        if (arr.length < 3) {
          return arr.push($(this));
        } else {
          arr.push($(this));
          high = arr[0];
          if (high.height() < arr[1].height()) {
            high = arr[1];
          }
          if (high.height() < arr[2].height()) {
            high = arr[2];
          }
          if (high.height() < arr[3].height()) {
            high = arr[3];
          }
          _.each(arr, function(o, i) {
            return o.height(high.height());
          });
          return arr = [];
        }
      });
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
