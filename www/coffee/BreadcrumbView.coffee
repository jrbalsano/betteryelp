LOAF.BreadcrumbView = Backbone.View.extend
  initHistory: (options) ->
    options = {} unless options
    @history = if options.history then options.history else []

  renderHistory: ->
    templateValues =
      historyItems: @history
      currentTitle: @title
    list = Mustache.render $(".template.history-list").html(), templateValues
    @$(".bcrumbs-path").html list
    @$(".history-link").click @_onHistoryClick

  _onHistoryClick: (e) ->
    e.preventDefault()
    @$el.hide()
    viewToShow = @history[e.currentTarget.dataset.id].view
    viewToShow.show()

