LOAF.SingleListView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-yelp-view'
  initialize: (options) ->
    @title = @collection.title || @collection.name
    @_historyRep = new LOAF.HistoryItem
      title: @title
      view: @
    @initHistory options

  render: ->
    html = ""
    obj =
      title: @collection.title || @collection.name
    html = Mustache.render LOAF.templates.bcSingleListView, obj
    @$el.html html
    @renderHistory()
