LOAF.ListSingleItemView = Backbone.View.extend
  tagName: "div"
  className: "bcrumbs-single-list-item bcrumbs-listing"

  initialize: (options)->
    @current = "none"
    @template = options.template

  events:
    "mouseover .icon-info-sign": "onShowInfo"
    "mouseover .icon-plus": "onShowAdd"
    "mouseover .icon-edit": "onShowEdit"
    "mouseover .icon-list": "onShowLists"
    "mouseover .icon-star": "onShowReviews"
    "click .icon-info-sign": "onClickInfo"
    "click .icon-plus": "onClickAdd"
    "click .icon-edit": "onClickEdit"
    "click .icon-list": "onClickLists"
    "click .icon-star": "onClickReviews"
    "click .icon-minus-sign": "onClickDelete"
    "mouseout .bcrumbs-single-icons": "onExit"
    "click .bc-list-checkbox": "onCheckToggle"
    "click .btn-info": "saveNotes"
    "keypress textarea": "changeNote"

  changeNote: (e) ->
    @$(".btn-success").addClass("btn-info").removeClass("btn-success")

  saveNotes: (e) ->
    note_text = @$("textarea").val()
    @model.set "notes", note_text
    @$(".btn-info").addClass "btn-success"
    @$(".btn-info").removeClass "btn-info"
    LOAF.appView.saveApplication()

  onClickInfo: ->
    if @current == "info"
      @current = "none"
    else
      @current = "info"

  onClickLists: ->
    if @current == "lists"
      @current = "none"
    else
      @current = "lists"

  onClickReviews: ->
    if @current == "reviews"
      @current = "none"
    else
      @current = "reviews"

  onClickAdd: (e) ->
    LOAF.allCrumbsList.add @model
    allCrumbsBox = _.filter @$('.bc-list-checkbox'), (chkbx) ->
      chkbx.dataset.id == "0"
    $(allCrumbsBox[0]).prop("checked", "checked")

  onClickEdit: ->
    if @current == "notes"
      @current = "none"
    else
      @current = "notes"

  onClickDelete: -> # alas, this does not work right now
    LOAF.allCrumbsList.remove @model

  onShowInfo: ->
    if @current == "info" or @current == "none"
      @$(".img-overlay-text >span").hide()
      @$(".img-overlay-text").show()
      @$(".img-overlay").show()
      @$(".bc-list-view-single-info").show()

  onShowAdd: ->
    if @current == "none"
      @$(".img-overlay-text >span").hide()
      @$(".img-overlay-text").show()
      @$(".img-overlay").show()
      @$(".bc-list-view-single-add").show()

  onShowLists: ->
    if @current == "lists" or @current == "none"
      @$(".img-overlay-text >span").hide()
      @$(".img-overlay-text").show()
      @$(".img-overlay").show()
      @$(".bc-list-view-single-lists").show()

  onShowReviews: ->
    if @current == "reviews" or @current == "none"
      @$(".img-overlay-text >span").hide()
      @$(".img-overlay-text").show()
      @$(".img-overlay").show()
      @$(".bc-list-view-single-reviews").show()

  onShowEdit: ->
    if @current == "edit" or @current == "none"
      @$(".img-overlay-text >span").hide()
      @$(".img-overlay-text").show()
      @$(".img-overlay").show()
      @$(".bc-list-view-single-notes").show()

  onExit: ->
    if @current == "none"
      @$(".img-overlay-text").hide()
      @$(".img-overlay").hide()

  onCheckToggle: (e) ->
    chkbx = $(e.srcElement)
    listId = e.srcElement.dataset.id
    if chkbx.prop("checked")
      LOAF.customLists.where(id: parseInt listId)[0].add @model
    else
      LOAF.customLists.where(id: parseInt listId)[0].remove @model

  render: ->
    @$el.html Mustache.render @template, @model.attributes
    checkboxes = ""
    _.each LOAF.customLists.getLists(), (list) =>
      obj =
        id: list.id
        name: list.name
      obj.checked = _.contains @model.get("listIds"), obj.id
      checkboxes += Mustache.render LOAF.templates.bcListCheckboxS, obj
    @$(".bc-list-checkboxes").html checkboxes
    @
