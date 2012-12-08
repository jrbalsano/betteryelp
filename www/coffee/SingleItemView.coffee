LOAF.SingleItemView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-single-view'
  current: 'info'
  #currentStates = 

  render: ->
    html = Mustache.render(LOAF.templates.bcSingleItem, (if @model then @model.attributes else {}) )
    @$el.html html

  events:
    #"click .bcrumbs-browse-category-toggle": "onCategoryToggle"
    "click .bcrumbs-single-item-info-link": "showInfo"
    "click .bcrumbs-single-item-notes-link": "showNotes"
    "click .bcrumbs-single-item-lists-link": "showLists"
    "click .bcrumbs-single-item-reviews-link": "showReviews"



  showInfo: ->
    if current != 'info'
      $(".bc-single-section-info-s").show()
      $(".bc-single-section-notes-s").hide()
      $(".bc-single-section-lists-s").hide()
      $(".bc-single-section-reviews-s").hide()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-info-link").addClass('active')
    current = 'info'

  showNotes: ->
    if current != 'notes'
      $(".bc-single-section-info-s").hide()
      $(".bc-single-section-notes-s").show()
      $(".bc-single-section-lists-s").hide()
      $(".bc-single-section-reviews-s").hide()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-notes-link").addClass('active')
    current = 'notes'

  showLists: ->
    if current != 'lists'
      $(".bc-single-section-info-s").hide()
      $(".bc-single-section-notes-s").hide()
      $(".bc-single-section-lists-s").show()
      $(".bc-single-section-reviews-s").hide()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-lists-link").addClass('active')
    current = 'lists'

  showReviews: ->
    if current != 'reviews'
      $(".bc-single-section-info-s").hide()
      $(".bc-single-section-notes-s").hide()
      $(".bc-single-section-lists-s").hide()
      $(".bc-single-section-reviews-s").show()
      $(".bcrumbs-single-item-tab").removeClass('active')
      $(".bcrumbs-single-item-reviews-link").addClass('active')
    current = 'reviews'