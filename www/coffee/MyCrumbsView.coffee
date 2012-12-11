LOAF.MyCrumbsView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-mycrumbs-view'
  initialize: ->
    @_historyRep = new LOAF.HistoryItem
      title: "My Crumbs"
      view: @

  events:
    "click .bcrumbs-list a": "onShowList"

  onShowList: (e) ->
    e.preventDefault
    debugger
    listId = parseInt e.srcElement.dataset.id
    el = $(".bcrumbs-list-view")
    LOAF.singleListView.undelegateEvents() if LOAF.singleListView?
    LOAF.singleListView = new LOAF.SingleListView
      collection: LOAF.customLists.where(id: listId)[0]
      el: el
      caller: @_historyRep
      type: "custom"
    LOAF.singleListView.render()
    @$el.hide()
    el.show()
    LOAF.singleListView.postRender()

  render: ->
    html = ""
    missingImage = "http://lorempixel.com/g/200/200/food"
    LOAF.customLists.each (list) ->
      obj =
        name: list.name
        image1: if list.size() > 0 then list.models[0].get("image_url") else missingImage
        image2: if list.size() > 1 then list.models[1].get("image_url") else missingImage
        image3: if list.size() > 2 then list.models[2].get("image_url") else missingImage
        id: list.id
      html += Mustache.render LOAF.templates.bcListViewList, obj
    @$(".bcrumbs-mycrumbs-section").html html
