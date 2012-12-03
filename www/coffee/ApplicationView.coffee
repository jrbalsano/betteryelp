LOAF.ApplicationView = Backbone.View.extend
  initialize: (options) ->
    $(".bcrumbs-view").hide()
    #MyBookmarksView.render()
    #AddBookmarksView.hide()
    $(".bcrumbs-mycrumbs-view").show()
    @fsObject = new LOAF.FsJsonObject
      read: false
      onReady: (fsObject) ->
        debugger
        newObject =
          a: 12
          b: 14
          c: 16
        fsObject.writeObject newObject, ->
          otherObject = new LOAF.FsJsonObject
            onReady: (newOtherObject) ->
              debugger
