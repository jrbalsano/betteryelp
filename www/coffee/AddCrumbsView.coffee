LOAF.AddCrumbsView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-yelp-view'
  initialize: ->
    @state = {}
    @state.browseExpanded = false

  events:
    "click .bcrumbs-browse-category-toggle": "onCategoryToggle"
    "click .bcrumbs-browse-collapse": "onCategoryToggle"
    "click .bcrumbs-list a": "onShowList"

  onShowList: (e) ->
    e.preventDefault
    listId = parseInt e.srcElement.dataset.id
    el = $(".bcrumbs-list-view")
    singleListView = new LOAF.SingleListView
      collection: LOAF.yelpLists.where(id: listId)[0]
      el: el
    singleListView.render()
    @$el.hide()
    el.show()

  onCategoryToggle: (e) ->
    e.preventDefault
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

  render: ->
    categoryHtml = ""
    _.each LOAF.yelpLists.getLists(), (list) ->
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
    @$(".bcrumbs-browse-collapse").hide()

    if (LOAF.yelpLists.where "term": false).length == 0 then @$(".bcrumbs-recent-searches-section").hide()
    @$(".bcrumbs-recent-searches-collapse").hide()
    @
