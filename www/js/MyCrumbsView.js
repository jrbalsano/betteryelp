// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.MyCrumbsView = LOAF.BreadcrumbView.extend({
    tagName: 'div',
    className: 'bcrumbs-mycrumbs-view',
    initialize: function() {
      return this._historyRep = new LOAF.HistoryItem({
        title: "My Crumbs",
        view: this
      });
    },
    events: {
      "click .bcrumbs-list a": "onShowList"
    },
    onShowList: function(e) {
      var el, listId, singleListView;
      e.preventDefault;
      listId = parseInt(e.srcElement.dataset.id);
      el = $(".bcrumbs-list-view");
      singleListView = new LOAF.SingleListView({
        collection: LOAF.customLists.where({
          id: listId
        })[0],
        el: el,
        caller: this._historyRep
      });
      singleListView.render();
      this.$el.hide();
      return el.show();
    },
    render: function() {
      var html, missingImage;
      html = "";
      missingImage = "http://lorempixel.com/g/200/200/food";
      LOAF.customLists.each(function(list) {
        var obj;
        obj = {
          name: list.name,
          image1: list.size() > 1 ? list.models[0].get("image_url") : missingImage,
          image2: list.size() > 1 ? list.models[1].get("image_url") : missingImage,
          image3: list.size() > 2 ? list.models[2].get("image_url") : missingImage,
          id: list.id
        };
        return html += Mustache.render(LOAF.templates.bcListViewList, obj);
      });
      return this.$(".bcrumbs-mycrumbs-section").html(html);
    }
  });

}).call(this);
