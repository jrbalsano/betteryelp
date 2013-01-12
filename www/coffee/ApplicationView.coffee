LOAF.ApplicationView = LOAF.BreadcrumbView.extend
  initialize: ->
    @initHistory()
    @$(".bcrumbs-view").hide()
    @$(".saving-cat").hide()
    @loadingTimeout = setTimeout( =>
      @$(".bcrumbs-loading").show()
    500)
    @startApplication @onStart, @

  onStart: ->
    clearTimeout @loadingTimeout
    @$(".bcrumbs-loading").hide()
    
    # create necessary views
    @addCrumbsView = new LOAF.AddCrumbsView
      el: @$(".bcrumbs-yelp-view")
    @myCrumbsView = new LOAF.MyCrumbsView
      el: @$(".bcrumbs-mycrumbs-view")

    # render pre-rendered views
    @addCrumbsView.render()
    @myCrumbsView.render()
    @$(".bcrumbs-mycrumbs-view").show()
    

  startApplication: (cb, context) ->
    loadApp = new LOAF.FsJsonObject
      onReady: (fs) =>
        data = fs.getObject()
        if data.sessionExists then @_loadSession data, cb, context else @_retrieveApiKeysFromUser cb, context

  events:
    "click .bcrumbs-add-crumbs-link": "showAddCrumbs"
    "click .bcrumbs-my-crumbs-link": "showMyCrumbs"
    "click .bcrumbs-header .add-on": "searchLists"
    "click .bc-footer-links > a": "showInstructions"
    "click .bcrumbs-undo": "onUndo"
    "click .bcrumbs-undo-hide": "hideUndo"

  setUndo: (text, command, f) ->
    html = "#{text} <a href=\"javascript:void(0)\" class=\"bcrumbs-undo\">#{command}</a> (<a href=\"javascript:void(0)\" class=\"bcrumbs-undo-hide\">hide this</a>)"
    @$(".bcrumbs-message p").html html
    @$(".bcrumbs-alert").animate top: "75px"
    setTimeout (=>
      @hideUndo()
      ), 15000
    @undo = f

  onUndo: (e) ->
    e.preventDefault()
    @undo()
    @hideUndo()

  hideUndo: (e) ->
    @$(".bcrumbs-alert").animate top: "0px"

  searchLists: (e) ->
    e.preventDefault()
    searchTerm = $(".bcrumbs-crumbs-search-input").val()
    if searchTerm
      searchArray = LOAF.customLists.search searchTerm
      el = $(".bcrumbs-list-view")
      searchResults = new LOAF.CustomList searchArray,
        name: "Search for: " + searchTerm
      LOAF.singleListView.undelegateEvents() if LOAF.singleListView?
      LOAF.singleListView = new LOAF.SingleListView
        collection: searchResults
        el: el
        caller:
          title: "My Crumbs"
          view: @myCrumbsView
        type: "custom"
      LOAF.singleListView.render()
      @$(".bcrumbs-view").hide()
      el.show()
      LOAF.singleListView.postRender()
      $(".edit-toggle").hide()
      $(".edit-mode").hide()

  showAddCrumbs: (e) ->
    e.preventDefault()
    @addCrumbsView.render()
    @$(".bcrumbs-view").hide()
    @$(".bcrumbs-yelp-view").show()
    @myCrumbs = !@myCrumbs

  showMyCrumbs: (e) ->
    e.preventDefault()
    @myCrumbsView.render()
    @$(".bcrumbs-view").hide()
    @$(".bcrumbs-mycrumbs-view").show()
    @myCrumbs = !@myCrumbs

  showInstructions: (e) ->
    e.preventDefault()
    @$(".bcrumbs-view").hide()
    @$(".bcrumbs-instructions-view").show()
    @myCrumbs = !@myCrumbs

  saveApplication: ->
    $(".saving-cat").show()
    object = {}
    object.sessionExists = true
    object.yelpLists = LOAF.yelpLists.getLists()
    object.customLists = LOAF.customLists.getLists()
    object.categories = LOAF.categories
    object.location = LOAF.location
    object.auth = LOAF.auth
    new LOAF.FsJsonObject
      read: false
      onReady: (newSave) ->
        newSave.writeObject object, ->
          console.log "Save complete"
          setTimeout( ->
            $(".saving-cat").hide()
          1000)

  _retrieveApiKeysFromUser: (cb, context) ->
    apiView = new LOAF.ApiView
      callback: @_retrieveCategoriesFromUser
      cbContext: @
      cbParams: [cb, context]
      el: @$(".bcrumbs-api-login")
    clearTimeout @loadingTimeout
    @$(".bcrumbs-loading").hide()
    apiView.$el.show()

  _retrieveCategoriesFromUser: (cb, context) ->
    @obView = new LOAF.OnboardView
      el: @$(".bcrumbs-onboard")
      callback: @_newSession
      cbContext: @
      cbParams: [cb, context]
    clearTimeout @loadingTimeout
    @$(".bcrumbs-loading").hide()
    @obView.render()
    @$(".bcrumbs-onboard").show()


  _newSession: (cb, context) ->
    @loadingTimeout = setTimeout( =>
      @$(".bcrumbs-loading").show()
    500)
    # Generate List of Yelp Lists
    LOAF.yelpLists = new LOAF.ListsList
    # create custom lists list and all crumbs list.
    LOAF.customLists = new LOAF.ListsList
    LOAF.allCrumbsList = new LOAF.CustomList [], name: "All Crumbs", isAllCrumbs: true
    LOAF.customLists.addList LOAF.allCrumbsList
    # Generate searches
    categoryLists = _.map LOAF.categories, (category) ->
      list = new LOAF.YelpList [], category: category
      list
    LOAF.yelpLists.addLists categoryLists
    LOAF.yelpLists.fetchLists ( =>
      # Save the new Session
      @saveApplication()
      #Call the callback
      cb.call(context)),
      (collection, xhr, options) ->
        console.log xhr
      


  _loadSession: (session, cb, context) ->
    console.log session

    LOAF.categories = session.categories
    LOAF.location = session.location
    LOAF.auth = session.auth
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
      customList = new LOAF.CustomList cL.models,
        name: cL.name
        isAllCrumbs: cL.isAllCrumbs
        id: cL.id
      tempCLs.push customList
      if customList.isAllCrumbs then LOAF.allCrumbsList = customList

    LOAF.customLists = new LOAF.ListsList lists: tempCLs
    
    # Call the callback
    cb.call(context)
