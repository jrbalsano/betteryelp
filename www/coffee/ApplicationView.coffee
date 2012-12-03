LOAF.ApplicationView = Backbone.View.extend
  initialize: ->
    @$(".bcrumbs-view").hide()
    #MyBookmarksView.render()
    #AddBookmarksView.hide()
    @$(".bcrumbs-mycrumbs-view").show()
    # eventually these show and hide should be replaced with view rendering
    # and loading all the date using the LOAF.FsJsonObject
    @myCrumbs = true

  events:
    "click .bcrumbs-add-crumbs-link": "showAddCrumbs"
    "click .bcrumbs-my-crumbs-link": "showMyCrumbs"

  showAddCrumbs: (e) ->
    e.preventDefault()
    if @myCrumbs
      @$(".bcrumbs-mycrumbs-view").hide()
      @$(".bcrumbs-yelp-view").show()
      @myCrumbs = !@myCrumbs

  showMyCrumbs: (e) ->
    e.preventDefault()
    unless @myCrumbs
      @$(".bcrumbs-yelp-view").hide()
      @$(".bcrumbs-mycrumbs-view").show()
      @myCrumbs = !@myCrumbs
