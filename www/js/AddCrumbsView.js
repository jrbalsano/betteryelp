// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.AddCrumbsView = LOAF.BreadcrumbView.extend({
    tagName: 'div',
    className: 'bcrumbs-yelp-view',
    initialize: function() {
      this.state = {};
      this.state.browseExpanded = false;
      this.state.searchesExpanded = false;
      return this._historyRep = new LOAF.HistoryItem({
        title: "Add Crumbs",
        view: this
      });
    },
    events: {
      "click .bcrumbs-browse-category-toggle": "onCategoryToggle",
      "click .bcrumbs-browse-collapse": "onCategoryToggle",
      "click .bcrumbs-list a": "onShowList",
      "click .bcrumbs-yelp-search .add-on": "searchForCrumbs",
      "click .bcrumbs-recent-searches-toggle": "onSearchesToggle",
      "click .bcrumbs-recent-searches-collapse": "onSearchesToggle"
    },
    searchForCrumbs: function(e) {
      var el, searchResults, searchTerm,
        _this = this;
      e.preventDefault();
      el = $(".bcrumbs-list-view");
      searchTerm = $(".bcrumbs-yelp-search-input").val();
      if (searchTerm) {
        searchResults = new LOAF.YelpList([], {
          term: searchTerm
        });
        return searchResults.fetch({
          success: function() {
            LOAF.yelpLists.addList(searchResults);
            if (LOAF.singleListView != null) {
              LOAF.singleListView.undelegateEvents();
            }
            LOAF.singleListView = new LOAF.SingleListView({
              collection: searchResults,
              el: el,
              caller: _this._historyRep,
              type: "yelp"
            });
            LOAF.singleListView.render();
            $(".bcrumbs-view").hide();
            el.show();
            LOAF.singleListView.postRender();
            return $(".iphone_switch_container").hide();
          }
        });
      }
    },
    onShowList: function(e) {
      var el, listId;
      e.preventDefault();
      listId = parseInt(e.srcElement.dataset.id);
      el = $(".bcrumbs-list-view");
      if (LOAF.singleListView != null) {
        LOAF.singleListView.undelegateEvents();
      }
      LOAF.singleListView = new LOAF.SingleListView({
        collection: LOAF.yelpLists.where({
          id: listId
        })[0],
        el: el,
        caller: this._historyRep,
        type: "yelp"
      });
      LOAF.singleListView.render();
      this.$el.hide();
      el.show();
      return LOAF.singleListView.postRender();
    },
    onCategoryToggle: function(e) {
      e.preventDefault();
      if (this.state.browseExpanded) {
        this.$(".bcrumbs-browse-category-toggle h3").html("Browse Categories +");
        _.each(this.$(".bcrumbs-browse-items >.bcrumbs-list.bcrumbs-listing"), function(o, i) {
          if (i > 2) {
            return $(o).hide();
          }
        });
        this.$(".bcrumbs-browse-collapse").hide();
        return this.state.browseExpanded = false;
      } else {
        this.$(".bcrumbs-browse-category-toggle h3").html("Browse Categories -");
        this.$(".bcrumbs-browse-items >.bcrumbs-list.bcrumbs-listing").show();
        this.$(".bcrumbs-browse-collapse").show();
        return this.state.browseExpanded = true;
      }
    },
    onSearchesToggle: function(e) {
      e.preventDefault();
      if (this.state.searchesExpanded) {
        this.$(".bcrumbs-recent-searches-toggle h3").html("Recent Searches +");
        _.each(this.$(".bcrumbs-recent-searches-items >.bcrumbs-list.bcrumbs-listing"), function(o, i) {
          if (i > 2) {
            return $(o).hide();
          }
        });
        this.$(".bcrumbs-recent-searches-collapse").hide();
        return this.state.searchesExpanded = false;
      } else {
        this.$(".bcrumbs-recent-searches-toggle h3").html("Recent Searches -");
        this.$(".bcrumbs-recent-searches-items >.bcrumbs-list.bcrumbs-listing").show();
        this.$(".bcrumbs-recent-searches-collapse").show();
        return this.state.searchesExpanded = true;
      }
    },
    render: function() {
      var categories, categoryHtml, searchHtml, searches;
      categoryHtml = "";
      if (LOAF.yelpLists.getLists().length > 0) {
        categories = _.filter(LOAF.yelpLists.getLists(), function(list) {
          return list.category != null;
        });
        _.each(categories, function(list) {
          var obj;
          obj = {
            name: list.category,
            image1: list.size() > 0 ? list.models[0].get("image_url") : void 0,
            image2: list.size() > 1 ? list.models[1].get("image_url") : void 0,
            image3: list.size() > 2 ? list.models[2].get("image_url") : void 0,
            id: list.id
          };
          return categoryHtml += Mustache.render(LOAF.templates.bcListViewList, obj);
        });
        this.$(".bcrumbs-browse-items").html(categoryHtml);
        _.each(this.$(".bcrumbs-browse-items >.bcrumbs-list.bcrumbs-listing"), function(o, i) {
          if (i > 2) {
            return $(o).hide();
          }
        });
      } else {
        categoryHtml = Mustache.render(LOAF.templates.bcSadCat, {
          message: "There are no categories available. Please refresh the page"
        });
        this.$(".bcrumbs-browse-items").html(categoryHtml);
      }
      this.$(".bcrumbs-browse-collapse").hide();
      searchHtml = "";
      searches = _.filter(LOAF.yelpLists.getLists(), function(list) {
        return list.term != null;
      });
      if (searches.length > 0) {
        _.each(searches, function(list) {
          var obj;
          obj = {
            name: list.term,
            image1: list.size() > 0 ? list.models[0].get("image_url") : void 0,
            image2: list.size() > 1 ? list.models[1].get("image_url") : void 0,
            image3: list.size() > 2 ? list.models[2].get("image_url") : void 0,
            id: list.id
          };
          searchHtml += Mustache.render(LOAF.templates.bcListViewList, obj);
          this.$(".bcrumbs-recent-searches-items").html(searchHtml);
          return _.each(this.$(".bcrumbs-recent-searches-items >.bcrumbs-list.bcrumbs-listing"), function(o, i) {
            if (i > 2) {
              return $(o).hide();
            }
          });
        });
      } else {
        searchHtml = Mustache.render(LOAF.templates.bcSadCat, {
          message: "You have no search history. Try a new search!"
        });
        this.$(".bcrumbs-recent-searches-items").html(searchHtml);
      }
      this.$(".bcrumbs-recent-searches-collapse").hide();
      return this;
    }
  });

}).call(this);
