LOAF.ApplicationView = LOAF.BreadcrumbView.extend
  initialize: ->
    @initHistory()
    @startApplication @onStart

  onStart: ->
    @$(".bcrumbs-view").hide()
    #MyBookmarksView.render()
    #AddBookmarksView.hide()
    @$(".bcrumbs-mycrumbs-view").show()
    @myCrumbs = true

  startApplication: (cb) ->
    loadApp = new LOAF.FsJsonObject
      onReady: (fs) =>
        # This function implements all the features
        data = fs.getObject()
        if data.sessionExists then @_loadSession data, cb else @_newSession cb

  events:
    "click .bcrumbs-add-crumbs-link": "showAddCrumbs"
    "click .bcrumbs-my-crumbs-link": "showMyCrumbs"

  showAddCrumbs: (e) ->
    e.preventDefault()
    if @myCrumbs
      @$(".bcrumbs-mycrumbs-view").hide()
      @$(".bcrumbs-yelp-view").show()
      @myCrumbs = !@myCrumbs

  showMyCrumbs: (e) ->
    e.preventDefault()
    unless @myCrumbs
      @$(".bcrumbs-yelp-view").hide()
      @$(".bcrumbs-mycrumbs-view").show()
      @myCrumbs = !@myCrumbs

  saveApplication: ->
    object = {}
    object.sessionExists = true
    object.yelpLists = LOAF.yelpLists
    object.customLists = LOAF.customLists
    new LOAF.FsJsonObject
      read: false
      onReady: (newSave) ->
        newSave.writeObject object, ->
          console.log "Save complete"

  _newSession: (cb) ->
    LOAF.customLists = new LOAF.ListsList()
    # Generate searches
    categories = ["active", "arts", "food", "hotelstravel", "localflavor", 
      "localservices", "nightlife", "restaurants", "shopping"]
    categoryLists = _.map categories, (category) ->
      list = new LOAF.YelpList [], category: category
      list.fetch()
      list
    LOAF.yelpLists = new LOAF.ListsList lists: categoryLists
    LOAF.allCrumbsList = new LOAF.CustomList name: "All Crumbs", isAllCrumbs: true
    LOAF.customLists.add LOAF.allCrumbsList
    # Save the new Session
    @saveApplication()
    #Call the callback
    cb()

  _loadSession: (session, cb) -> 
    # load in the yelp lists, creating models and collections
    yLs = session.yelpLists
    tempYLs = []
    _.each yLs, (yL) ->
      tempYLs.push new LOAF.YelpList yL
    LOAF.yelpLists = new LOAF.ListsList tempYLs

    #load in the custom lists, creating models and collections
    cLs = session.customLists
    tempCLs = []
    _.each cLs, (cL) ->
      tempYLs.push new LOAF.CustomList cL
    LOAF.customLists = new LOAF.ListsList tempCLs
    
    # Call the callback
    cb()
