LOAF.ListSingleItemView = Backbone.View.extend
  tagName: "div"
  className: "bcrumbs-single-list-item bcrumbs-listing"

  initialize: (options)->
    @current = "none"
    @template = options.template

  events:
    "mouseover .bcrumbs-mouseover-info": "onShowInfo"
    "mouseover .bcrumbs-mouseover-plus": "onShowAdd"
    "mouseover .bcrumbs-mouseover-edit": "onShowEdit"
    "mouseover .bcrumbs-mouseover-list": "onShowLists"
    "mouseover .bcrumbs-mouseover-star": "onShowReviews"
    "mouseover .bcrumbs-mouseover-trash": "onShowDelete"
    "click .bcrumbs-mouseover-info": "onClickInfo"
    "click .bcrumbs-mouseover-plus": "onClickAdd"
    "click .bcrumbs-mouseover-ok": "onClickRemove"
    "click .bcrumbs-mouseover-edit": "onClickEdit"
    "click .bcrumbs-mouseover-list": "onClickLists"
    "click .bcrumbs-mouseover-star": "onClickReviews"
    "click .bcrumbs-mouseover-trash": "onClickDelete"
    "mouseout .bcrumbs-single-icons": "onExit"
    "click .bc-list-checkbox": "onCheckToggle"
    "click .btn-info": "saveNotes"
    "keypress textarea": "changeNote"
    "click .close": "closeHover"

  closeHover: ->
    @$(".btn").removeClass("active")
    @$('.img-overlay-text').hide()
    @$('.img-overlay').hide()
    @current = "none"

  changeNote: (e) ->
    @$(".btn-success").addClass("btn-info").removeClass("btn-success")

  saveNotes: (e) ->
    note_text = @$("textarea").val()
    @model.set "notes", note_text
    @$(".btn-info").addClass "btn-success"
    @$(".btn-info").removeClass "btn-info"
    LOAF.appView.saveApplication()

  onClickInfo: (e) ->
    @$(".btn").removeClass("active")
    if @current == "info"
      @current = "none"
    else
      @$(".bcrumbs-mouseover-info").button('toggle')
      @current = "info"
      @onShowInfo(e)

  onClickLists: (e) ->
    @$(".btn").removeClass("active")
    if @current == "lists"
      @current = "none"
    else
      @current = "lists"
      @$(".bcrumbs-mouseover-list").button('toggle')
      @onShowLists(e)

  onClickReviews: (e) ->
    @$(".btn").removeClass("active")
    if @current == "reviews"
      @current = "none"
    else
      @current = "reviews"
      @$(".bcrumbs-mouseover-star").button('toggle')
      @onShowReviews(e)

  onClickAdd: (e) ->
    @$(".icon-plus").addClass("icon-ok").removeClass "icon-plus"
    @$(".add-message").empty().append "Added to your Crumbs!"
    LOAF.allCrumbsList.add @model
    allCrumbsBox = _.filter @$('.bc-list-checkbox'), (chkbx) ->
      chkbx.dataset.id == "0"
    $(allCrumbsBox[0]).prop("checked", "checked")

  onClickRemove: (e) ->
    console.log "onclick"
    @$(".icon-ok").addClass("icon-plus").removeClass "icon-ok"
    LOAF.allCrumbsList.remove @model
    @model
    _.each @model.get("listIds"), (id) =>
      list = LOAF.customLists.where(id: id)[0]
      if list?
        list.remove @model.id
        @model.attributes.listIds = _.without @model.attributes.listIds, list.id
    @$(".bc-list-checkbox").prop("checked", false)


  onClickEdit: ->
    @$(".btn").removeClass("active")
    if @current == "notes"
      @current = "none"
    else
      @$(".bcrumbs-mouseover-edit").button('toggle')
      @current = "notes"

  onClickDelete: ->
    @$el.hide()
    index = @collection.indexOf @model
    @collection.remove @model
    LOAF.appView.setUndo "#{@model.name} removed from #{@collection.name}.", "Undo?", =>
      @collection.add @model, at: index
      @$el.show()
    
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

  onShowDelete: ->
    if @current == "delete" or @current == "none"
      @$(".img-overlay-text >span").hide()
      @$(".img-overlay-text").show()
      @$(".img-overlay").show()
      @$(".bc-list-view-single-delete").show()

  onExit: ->
    if @current == "none"
      @$(".img-overlay-text").hide()
      @$(".img-overlay").hide()

  onCheckToggle: (e) ->
    chkbx = $(e.srcElement)
    listId = e.srcElement.dataset.id
    if listId == "0"
      el = @$(".icon-plus, .icon-ok")
      el.toggleClass("icon-ok").toggleClass "icon-plus"
    if chkbx.prop("checked")
      LOAF.allCrumbsList.add @model
      allCrumbsCheck = _.find @$(".bc-list-checkbox"), (eachCheck) ->
        eachCheck.dataset.id == "0"
      $(allCrumbsCheck).prop("checked", true)
      el = @$(".icon-plus, .icon-ok")
      el.removeClass("icon-plus").removeClass("icon-ok").addClass("icon-ok")
      LOAF.customLists.where(id: parseInt listId)[0].add @model
    else
      LOAF.customLists.where(id: parseInt listId)[0].remove @model
      if listId == "0"
        try
          _.each @model.get("listIds"), (id) =>
            list = LOAF.customLists.where(id: id)[0]
            if list?
              list.remove @model.id
              @model.attributes.listIds = _.without @model.attributes.listIds, list.id
        finally
          @$(".bc-list-checkbox").prop("checked", false)

  render: ->
    @$el.html Mustache.render @template, @model.attributes

    # render checkboxes
    checkboxes = ""
    _.each LOAF.customLists.getLists(), (list) =>
      obj =
        id: list.id
        name: list.name
      obj.checked = _.contains @model.get("listIds"), obj.id
      checkboxes += Mustache.render LOAF.templates.bcListCheckboxS, obj
    @$(".bc-list-checkboxes").html checkboxes

    # render add sign to match checkboxes
    if LOAF.allCrumbsList.get @model.id
      @$(".icon-plus").addClass("icon-ok").removeClass "icon-plus"
      
    @
