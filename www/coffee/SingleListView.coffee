LOAF.SingleListView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-list-view'
  initialize: (options) ->
    @title = @collection.title || @collection.name
    @type = options.type
    @_historyRep = new LOAF.HistoryItem
      title: @title
      view: @
    @initHistory options

  events:
    "click .bcrumbs-single-list-view-link a": "onShowItem"

  onShowItem: (e) ->
    e.preventDefault()
    LOAF.singleView.undelegateEvents() if LOAF.singleView?
    LOAF.singleView = new LOAF.SingleItemView
      el: $(".bcrumbs-single-view")
      model: @collection.get(e.srcElement.dataset.id)
      caller: @_historyRep
      history: @history.slice(0)
    LOAF.singleView.render()
    @$el.hide()
    LOAF.singleView.$el.show()

  render: ->
    # Create Basic Layout
    html = ""
    obj =
      title: @collection.title || @collection.name
    html = Mustache.render LOAF.templates.bcSingleListView, obj
    @$el.html html

    # Add individual business
    listItemViews = []
    template = if @type == "yelp" then LOAF.templates.bcYelpViewSingle else LOAF.templates.bcListViewSingle
    @collection.each (business) ->
      listItemViews.push new LOAF.ListSingleItemView
        model: business
        template: template
    _.each listItemViews, (o) ->
      o.render()
      @$(".bcrumbs-list-view-items").append o.el
    @listItemViews = listItemViews

    # render history
    @renderHistory()
