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
      "click .bcrumbs-list .bcrumbs-show-list": "onShowList",
      "click .bcrumbs-list-add": "onAddNewList",
      "click .listname-confirm": "confirmNewList",
      "keypress .bcrumbs-listname": "onkey",
      "click .delete": "onDelete"
    },
    onDelete: function(e) {
      var list, listId;
      e.preventDefault();
      $(e.srcElement.parentElement.parentElement).hide();
      listId = e.srcElement.dataset.id;
      list = LOAF.customLists.where({
        id: parseInt(listId)
      });
      return LOAF.customLists.removeList(list[0]);
    },
    onkey: function(e) {
      if (e.keyCode === 13) {
        return this.confirmNewList(e);
      }
    },
    onShowList: function(e) {
      var el, listId;
      e.preventDefault;
      listId = parseInt(e.srcElement.dataset.id);
      el = $(".bcrumbs-list-view");
      if (LOAF.singleListView != null) {
        LOAF.singleListView.undelegateEvents();
      }
      LOAF.singleListView = new LOAF.SingleListView({
        collection: LOAF.customLists.where({
          id: listId
        })[0],
        el: el,
        caller: this._historyRep,
        type: "custom"
      });
      LOAF.singleListView.render();
      this.$el.hide();
      el.show();
      return LOAF.singleListView.postRender();
    },
    onAddNewList: function() {
      this.$('#bcrumbs-new-list-text').hide();
      return this.$('.new-list-name').show();
    },
    confirmNewList: function(e) {
      var newCustomList;
      e.preventDefault();
      newCustomList = new LOAF.CustomList([], {
        name: this.$(".bcrumbs-listname").val()
      });
      LOAF.customLists.addList(newCustomList);
      this.render();
      return LOAF.appView.saveApplication();
    },
    render: function() {
      var html, missingImage;
      html = "";
      missingImage = "http://lorempixel.com/g/200/200/food";
      LOAF.customLists.each(function(list) {
        var obj;
        obj = {
          name: list.name,
          image1: list.size() > 0 ? list.models[0].get("image_url") : missingImage,
          image2: list.size() > 1 ? list.models[1].get("image_url") : missingImage,
          image3: list.size() > 2 ? list.models[2].get("image_url") : missingImage,
          id: list.id
        };
        return html += Mustache.render(LOAF.templates.bcListViewList, obj);
      });
      html += LOAF.templates.bcListAdd;
      return this.$(".bcrumbs-mycrumbs-section").html(html);
    }
  });

}).call(this);
