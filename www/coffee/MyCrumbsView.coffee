LOAF.MyCrumbsView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-mycrumbs-view'
  initialize: ->
    @_historyRep = new LOAF.HistoryItem
      title: "My Crumbs"
      view: @

  events:
    "click .bcrumbs-list .bcrumbs-show-list": "onShowList"
    "click .bcrumbs-list-add": "onAddNewList"
    "click .listname-confirm": "confirmNewList"
    "keypress .bcrumbs-listname": "onkey"
    "click .delete": "onDelete"

  onDelete: (e) ->
    e.preventDefault()
    $(e.srcElement.parentElement.parentElement).hide()
    listId = e.srcElement.dataset.id
    list = LOAF.customLists.where id: parseInt listId
    index = LOAF.customLists.lists.indexOf list[0]
    LOAF.customLists.removeList list[0]
    LOAF.appView.setUndo "#{list[0].name} has been deleted.", "Undo?", =>
      LOAF.customLists.lists.splice index, 0, list[0]
      @render()

  onkey: (e) ->
    if e.keyCode == 13
      @confirmNewList(e)

  onShowList: (e) ->
    e.preventDefault
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

  onAddNewList: ->
    @$('#bcrumbs-new-list-text').hide()
    @$('.new-list-name').show()

  confirmNewList: (e)->
    e.preventDefault()
    newCustomList = new LOAF.CustomList [],
      name: @$(".bcrumbs-listname").val()
    LOAF.customLists.addList newCustomList
    @render()
    LOAF.appView.saveApplication()

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
    html += LOAF.templates.bcListAdd
    @$(".bcrumbs-mycrumbs-section").html html
    @$('.delete').show()
