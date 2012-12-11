LOAF.SingleItemView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-single-view'
  current: 'info'

  initialize: (options) ->
    @title = @model.get("name")
    @initHistory options

  render: ->
    html = Mustache.render(LOAF.templates.bcSingleItem, (if @model then @model.attributes else {}) )
    @$el.html html
    
    checkboxes = ""
    _.each LOAF.customLists.getLists(), (list) =>
      obj =
        id: list.id
        name: list.name
      obj.checked = _.contains @model.get("listIds"), obj.id
      checkboxes += Mustache.render LOAF.templates.bcListCheckboxS, obj
    @$(".bc-list-checkboxes").html checkboxes

    @renderHistory()


  events:
    "click .bcrumbs-single-item-info-link": "showInfo"
    "click .bcrumbs-single-item-notes-link": "showNotes"
    "click .bcrumbs-single-item-lists-link": "showLists"
    "click .bcrumbs-single-item-reviews-link": "showReviews"
    "click .bcrumbs-single-item-section-notes .btn-info": "saveNotes"
    "keypress textarea": "changeNotes"
    "click .bc-list-checkbox": "onCheckToggle"

  saveNotes: (e) ->
    note_text = @$(".bcrumbs-single-item-section-notes textarea").val()
    @model.set "notes", note_text
    @$(".bcrumbs-single-item-section-notes .btn-info").addClass "btn-success"
    @$(".bcrumbs-single-item-section-notes .btn-info").removeClass "btn-info"
    LOAF.appView.saveApplication()

  changeNotes: () ->
    @$(".bcrumbs-single-item-section-notes .btn-success").addClass("btn-info").removeClass("btn-success")

  onCheckToggle: (e) ->
    chkbx = $(e.srcElement)
    listId = e.srcElement.dataset.id
    if chkbx.prop("checked")
      LOAF.customLists.where(id: parseInt listId)[0].add @model
    else
      LOAF.customLists.where(id: parseInt listId)[0].remove @model
      if listId == "0"
        _.each @model.get("listIds"), (id) =>
          LOAF.customLists.where(id: id)[0].remove @model.id
          @model.attributes.listIds = _.without @model.attributes.listIds, list.id
        @$(".bc-list-checkbox").prop("checked", false)
          


  showInfo: ->
    if @current != 'info'
      $(".bcrumbs-single-item-section-info").show()
      $(".bcrumbs-single-item-section-notes").hide()
      $(".bcrumbs-single-item-section-lists").hide()
      $(".bcrumbs-single-item-section-reviews").hide()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-info-link").addClass('active')
    @current = 'info'

  showNotes: ->
    if @current != 'notes'
      $(".bcrumbs-single-item-section-info").hide()
      $(".bcrumbs-single-item-section-notes").show()
      $(".bcrumbs-single-item-section-lists").hide()
      $(".bcrumbs-single-item-section-reviews").hide()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-notes-link").addClass('active')
    @current = 'notes'

  showLists: ->
    if @current != 'lists'
      $(".bcrumbs-single-item-section-info").hide()
      $(".bcrumbs-single-item-section-notes").hide()
      $(".bcrumbs-single-item-section-lists").show()
      $(".bcrumbs-single-item-section-reviews").hide()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-lists-link").addClass('active')
    @current = 'lists'

  showReviews: ->
    if @current != 'reviews'
      $(".bcrumbs-single-item-section-info").hide()
      $(".bcrumbs-single-item-section-notes").hide()
      $(".bcrumbs-single-item-section-lists").hide()
      $(".bcrumbs-single-item-section-reviews").show()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-reviews-link").addClass('active')
    @current = 'reviews'
