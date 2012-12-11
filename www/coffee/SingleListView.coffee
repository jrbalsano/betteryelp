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

  postRender: ->
    #Truncate business names
    @$('.bcrumbs-single-list-view-link').each (i)->
      if $(@).text.length > 20 then $(@).val($(@).text().substring(0, 20))
    #Adjust heights
    arr = []
    @$('.bcrumbs-single-list-item').each (i)->
      #if array size is less than three
      $(@).next('bcrumbs-single-list-view-link').jTruncate(length: 20)
      if arr.length < 3
        #push to array
        arr.push $(@)
      else
        arr.push $(@)
        #find the tallest of the three and make their heights the same
        high = arr[0]
        if high.height() < arr[1].height() then high = arr[1] 
        if high.height() < arr[2].height() then high = arr[2]
        if high.height() < arr[3].height() then high = arr[3]
        _.each arr, (o, i) ->
          o.height high.height()
        #dump array
        arr = []

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
