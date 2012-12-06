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
    object.yelpLists = LOAF.yelpLists.getLists()
    object.customLists = LOAF.customLists.getLists()
    new LOAF.FsJsonObject
      read: false
      onReady: (newSave) ->
        newSave.writeObject object, ->
          console.log "Save complete"

  _newSession: (cb) ->
    # Generate List of Yelp Lists
    LOAF.yelpLists = new LOAF.ListsList
    # create custom lists list and all crumbs list.
    LOAF.customLists = new LOAF.ListsList()
    LOAF.allCrumbsList = new LOAF.CustomList [], name: "All Crumbs", isAllCrumbs: true
    LOAF.customLists.addList LOAF.allCrumbsList
    # Generate searches
    categories = ["active", "arts", "food", "hotelstravel", "localflavor", 
      "localservices", "nightlife", "restaurants", "shopping"]
    categoryLists = _.map categories, (category) ->
      list = new LOAF.YelpList [], category: category
      list.fetch()
      list
    LOAF.yelpLists.addLists categoryLists
    # Save the new Session
    @saveApplication()
    #Call the callback
    cb()

  _loadSession: (session, cb) -> 
    console.log session
    # load in the yelp lists, creating models and collections
    yLs = session.yelpLists
    tempYLs = []
    _.each yLs, (yL) ->
      tempYLs.push new LOAF.YelpList yL.models,
        category: yL.category
        term: yL.term
        id: yL.id
    LOAF.yelpLists = new LOAF.ListsList lists: tempYLs

    #load in the custom lists, creating models and collections
    cLs = session.customLists
    tempCLs = []
    _.each cLs, (cL) ->
      customList = new LOAF.CustomList cL,
        name: cL.name
        isAllCrumbs: cL.isAllCrumbs
        id: cL.id
      tempCLs.push customList
      if customList.isAllCrumbs then LOAF.allCrumbsList = customList

    LOAF.customLists = new LOAF.ListsList lists: tempCLs
    
    # Call the callback
    cb()
