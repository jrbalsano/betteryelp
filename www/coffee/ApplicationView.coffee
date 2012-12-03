LOAF.ApplicationView = Backbone.View.extend
  tagName: div
  
  className: bcrumbs-wrapper
  
  intialize: (options) ->
    @$(".bcrumbs-view").hide()
    #MyBookmarksView.render()
    #AddBookmarksView.hide()
    @$(".bcrumbs-mycrumbs-view").show()
