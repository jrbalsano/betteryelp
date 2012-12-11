LOAF.AddCrumbsView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-yelp-view'
  initialize: ->
    @state = {}
    @state.browseExpanded = false
    @state.searchesExpanded = false
    @_historyRep = new LOAF.HistoryItem
      title: "Add Crumbs"
      view: @

  events:
    "click .bcrumbs-browse-category-toggle": "onCategoryToggle"
    "click .bcrumbs-browse-collapse": "onCategoryToggle"
    "click .bcrumbs-list a": "onShowList"
    "click .bcrumbs-yelp-search .add-on": "searchForCrumbs"
    "click .bcrumbs-recent-searches-toggle": "onSearchesToggle"
    "click .bcrumbs-recent-searches-collapse": "onSearchesToggle"

  searchForCrumbs: (e) ->
    e.preventDefault()
    el = $(".bcrumbs-list-view")
    searchTerm = $(".bcrumbs-yelp-search-input").val()
    if searchTerm
      searchResults = new LOAF.YelpList [],
        term: searchTerm
      searchResults.fetch
        success: =>
          LOAF.yelpLists.addList searchResults
          LOAF.singleListView.undelegateEvents() if LOAF.singleListView?
          LOAF.singleListView = new LOAF.SingleListView
            collection: searchResults
            el: el
            caller: @_historyRep
            type: "yelp"
          LOAF.singleListView.render()
          $(".bcrumbs-view").hide()
          el.show()
          LOAF.singleListView.postRender()
          $(".edit-toggle").hide()
          $(".edit-mode").hide()

  onShowList: (e) ->
    e.preventDefault()
    listId = parseInt e.srcElement.dataset.id
    el = $(".bcrumbs-list-view")
    LOAF.singleListView.undelegateEvents() if LOAF.singleListView?
    LOAF.singleListView = new LOAF.SingleListView
      collection: LOAF.yelpLists.where(id: listId)[0]
      el: el
      caller: @_historyRep
      type: "yelp"
    LOAF.singleListView.render()
    @$el.hide()
    el.show()
    LOAF.singleListView.postRender()
    $(".edit-toggle").hide()
    $(".edit-mode").hide()

  onCategoryToggle: (e) ->
    e.preventDefault()
    if @state.browseExpanded
      @$(".bcrumbs-browse-category-toggle h3").html "Browse Categories +"
      _.each @$(".bcrumbs-browse-items >.bcrumbs-list.bcrumbs-listing"), (o, i) ->
        $(o).hide() if i > 2
      @$(".bcrumbs-browse-collapse").hide()
      @state.browseExpanded = false
    else
      @$(".bcrumbs-browse-category-toggle h3").html "Browse Categories -"
      @$(".bcrumbs-browse-items >.bcrumbs-list.bcrumbs-listing").show()
      @$(".bcrumbs-browse-collapse").show()
      @state.browseExpanded = true

  onSearchesToggle: (e) ->
    e.preventDefault()
    if @state.searchesExpanded
      @$(".bcrumbs-recent-searches-toggle h3").html "Recent Searches +"
      _.each @$(".bcrumbs-recent-searches-items >.bcrumbs-list.bcrumbs-listing"), (o, i) ->
        $(o).hide() if i > 2
      @$(".bcrumbs-recent-searches-collapse").hide()
      @state.searchesExpanded = false
    else
      @$(".bcrumbs-recent-searches-toggle h3").html "Recent Searches -"
      @$(".bcrumbs-recent-searches-items >.bcrumbs-list.bcrumbs-listing").show()
      @$(".bcrumbs-recent-searches-collapse").show()
      @state.searchesExpanded = true

  render: ->
    categoryHtml = ""
    if LOAF.yelpLists.getLists().length > 0
      categories = _.filter LOAF.yelpLists.getLists(), (list) ->
        list.category?
      _.each categories, (list) ->
        obj =
          name: list.category,
          image1: if list.size() > 0 then list.models[0].get("image_url")
          image2: if list.size() > 1 then list.models[1].get("image_url")
          image3: if list.size() > 2 then list.models[2].get("image_url")
          id: list.id
        categoryHtml += Mustache.render LOAF.templates.bcListViewList, obj
      @$(".bcrumbs-browse-items").html categoryHtml
      _.each @$(".bcrumbs-browse-items >.bcrumbs-list.bcrumbs-listing"), (o, i) ->
        $(o).hide() if i > 2
    else
      categoryHtml = Mustache.render LOAF.templates.bcSadCat, message: "There are no categories available. Please refresh the page"
      @$(".bcrumbs-browse-items").html categoryHtml
    @$(".bcrumbs-browse-collapse").hide()
    @$(".edit-toggle").hide()

    searchHtml = ""
    searches = _.filter LOAF.yelpLists.getLists(), (list) ->
      list.term?
    if searches.length > 0
      _.each searches, (list) ->
        obj =
          name: list.term
          image1: if list.size() > 0 then list.models[0].get("image_url")
          image2: if list.size() > 1 then list.models[1].get("image_url")
          image3: if list.size() > 2 then list.models[2].get("image_url")
          id: list.id
        searchHtml += Mustache.render LOAF.templates.bcListViewList, obj
        @$(".bcrumbs-recent-searches-items").html searchHtml
        _.each @$(".bcrumbs-recent-searches-items >.bcrumbs-list.bcrumbs-listing"), (o, i) ->
          $(o).hide() if i > 2
    else
      searchHtml = Mustache.render LOAF.templates.bcSadCat, message: "You have no search history. Try a new search!"
      @$(".bcrumbs-recent-searches-items").html searchHtml
    @$(".bcrumbs-recent-searches-collapse").hide()
    @
