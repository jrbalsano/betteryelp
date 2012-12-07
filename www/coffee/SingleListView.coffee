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

  render: ->
    # Create Basic Layout
    html = ""
    obj =
      title: @collection.title || @collection.name
    html = Mustache.render LOAF.templates.bcSingleListView, obj
    @$el.html html

    # Add individual business
    itemsHtml = ""
    template = if @type == "yelp" then LOAF.templates.bcYelpViewSingle else LOAF.templates.bcListViewSingle
    @collection.each (business) ->
      itemsHtml += Mustache.render template, business.attributes
    @$(".bcrumbs-list-view-items").html itemsHtml

    # render history
    @renderHistory()
