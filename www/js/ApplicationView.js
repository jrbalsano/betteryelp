// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.ApplicationView = LOAF.BreadcrumbView.extend({
    initialize: function() {
      var _this = this;
      this.initHistory();
      this.$(".bcrumbs-view").hide();
      this.loadingTimeout = setTimeout(function() {
        return _this.$(".bcrumbs-loading").show();
      }, 500);
      return this.startApplication(this.onStart, this);
    },
    onStart: function() {
      clearTimeout(this.loadingTimeout);
      console.log("completed loading");
      this.$(".bcrumbs-loading").hide();
      this.addCrumbsView = new LOAF.AddCrumbsView({
        el: this.$(".bcrumbs-yelp-view")
      });
      this.myCrumbsView = new LOAF.MyCrumbsView({
        el: this.$(".bcrumbs-mycrumbs-view")
      });
      this.addCrumbsView.render();
      this.myCrumbsView.render();
      return this.$(".bcrumbs-mycrumbs-view").show();
    },
    startApplication: function(cb, context) {
      var loadApp,
        _this = this;
      return loadApp = new LOAF.FsJsonObject({
        onReady: function(fs) {
          var data;
          data = fs.getObject();
          if (data.sessionExists) {
            return _this._loadSession(data, cb, context);
          } else {
            return _this._newSession(cb, context);
          }
        }
      });
    },
    events: {
      "click .bcrumbs-add-crumbs-link": "showAddCrumbs",
      "click .bcrumbs-my-crumbs-link": "showMyCrumbs"
    },
    showAddCrumbs: function(e) {
      e.preventDefault();
      this.addCrumbsView.render();
      this.$(".bcrumbs-view").hide();
      this.$(".bcrumbs-yelp-view").show();
      return this.myCrumbs = !this.myCrumbs;
    },
    showMyCrumbs: function(e) {
      e.preventDefault();
      this.myCrumbsView.render();
      this.$(".bcrumbs-view").hide();
      this.$(".bcrumbs-mycrumbs-view").show();
      return this.myCrumbs = !this.myCrumbs;
    },
    saveApplication: function() {
      var object;
      object = {};
      object.sessionExists = true;
      object.yelpLists = LOAF.yelpLists.getLists();
      object.customLists = LOAF.customLists.getLists();
      return new LOAF.FsJsonObject({
        read: false,
        onReady: function(newSave) {
          return newSave.writeObject(object, function() {
            return console.log("Save complete");
          });
        }
      });
    },
    _newSession: function(cb, context) {
      var categories, categoryLists,
        _this = this;
      LOAF.yelpLists = new LOAF.ListsList;
      LOAF.customLists = new LOAF.ListsList;
      LOAF.allCrumbsList = new LOAF.CustomList([], {
        name: "All Crumbs",
        isAllCrumbs: true
      });
      LOAF.customLists.addList(LOAF.allCrumbsList);
      categories = ["active", "arts", "food", "hotelstravel", "localflavor", "localservices", "nightlife", "restaurants", "shopping"];
      categoryLists = _.map(categories, function(category) {
        var list;
        list = new LOAF.YelpList([], {
          category: category
        });
        return list;
      });
      LOAF.yelpLists.addLists(categoryLists);
      return LOAF.yelpLists.fetchLists((function() {
        _this.saveApplication();
        return cb.call(context);
      }), function(collection, xhr, options) {
        return console.log(xhr);
      });
    },
    _loadSession: function(session, cb, context) {
      var cLs, tempCLs, tempYLs, yLs;
      console.log(session);
      yLs = session.yelpLists;
      tempYLs = [];
      _.each(yLs, function(yL) {
        return tempYLs.push(new LOAF.YelpList(yL.models, {
          category: yL.category,
          term: yL.term,
          id: yL.id
        }));
      });
      LOAF.yelpLists = new LOAF.ListsList({
        lists: tempYLs
      });
      cLs = session.customLists;
      tempCLs = [];
      _.each(cLs, function(cL) {
        var customList;
        customList = new LOAF.CustomList(cL.models, {
          name: cL.name,
          isAllCrumbs: cL.isAllCrumbs,
          id: cL.id
        });
        tempCLs.push(customList);
        if (customList.isAllCrumbs) {
          return LOAF.allCrumbsList = customList;
        }
      });
      LOAF.customLists = new LOAF.ListsList({
        lists: tempCLs
      });
      return cb.call(context);
    }
  });

}).call(this);
