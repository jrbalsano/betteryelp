$(document).ready ->
  $.get "mustache-templates.html", (templates) ->
    temps = $(templates)
    getTemplate = (templateName) ->
      temps.filter("##{templateName}").html()
    LOAF.templates = {}
    LOAF.templates.bcHistory = getTemplate "bc-history"
    LOAF.templates.bcListViewList = getTemplate "bc-list-view-list" 
    LOAF.templates.bcListViewSingle = getTemplate "bc-list-view-single"
    LOAF.templates.bcListViewSingleInfoS = getTemplate "bc-list-view-single-info-s"
    LOAF.templates.bcListViewSingleNotesS = getTemplate "bc-list-view-single-notes-s"
    LOAF.templates.bcListViewSingleListsS = getTemplate "bc-list-view-single-lists-s"
    LOAF.templates.bcListViewSingleReviewsS = getTemplate "bc-list-view-single-reviews-s"
    LOAF.templates.bcListViewSingleAddS = getTemplate "bc-list-view-single-add-s"
    LOAF.templates.bcYelpViewSingle = getTemplate "bc-yelp-view-single"
    LOAF.templates.bcSingleItem = getTemplate "bc-single-item"
    LOAF.templates.bcSingleSectionInfoS = getTemplate "bc-single-section-info-s"
    LOAF.templates.bcSingleSectionNotesS = getTemplate "bc-single-section-notes-s"
    LOAF.templates.bcSingleSectionListsS = getTemplate "bc-single-section-lists-s"
    LOAF.templates.bcSingleSectionReviewsS = getTemplate "bc-single-section-reviews-s"
    LOAF.templates.bcSingleListView = getTemplate "bc-single-list-view"
    LOAF.templates.bcListCheckboxS = getTemplate "bc-list-checkbox-s"
