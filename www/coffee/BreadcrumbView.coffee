LOAF.BreadcrumbView = Backbone.View.extend
  initHistory: (options) ->
    options = {} unless options
    @history = if options.history then options.history else []
    options.caller.id = @history.length if options.caller
    @history.push options.caller

  renderHistory: ->
    templateValues =
      historyItems: @history
      currentTitle: @title
    list = Mustache.render $(".template.history-list").html(), templateValues
    @$(".bcrumbs-path").html list
    @$(".history-link").click (e) =>
      @_onHistoryClick(e)

  _onHistoryClick: (e) ->
    e.preventDefault()
    @$el.hide()
    viewToShow = @history[e.currentTarget.dataset.id].view
    viewToShow.$el.show()

class LOAF.HistoryItem
  constructor: (options) ->
    @view = options.view
    @title = options.title
