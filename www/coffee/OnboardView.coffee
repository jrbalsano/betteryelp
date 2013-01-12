LOAF.OnboardView = Backbone.View.extend
  initialize: (options)->
    @callback = options.callback
    @cbContext = options.cbContext
    @cbParams = options.cbParams
    @categories = []

  events:
    "click .collapsable-list-toggle": "onToggle"
    "change input:checkbox": "onChecking"
    "keyup .user-location": "onKeyUp"
    "click .save-categories": "onSave"

  onKeyUp: (e) ->
    if @$(".user-location").val()
      @$(".save-categories").removeAttr("disabled")
    else
      @$(".save-categories").attr("disabled", "true")

  onChecking: (e) ->
    if e.srcElement.checked
      @categories.push e.srcElement.value
    else
      @categories = _(@categories).without e.srcElement.value

  onToggle: (e) ->
    e.preventDefault()
    $(e.srcElement).parent().children("ul").toggle("slow")
    switch $(e.srcElement).html()
      when "(show more)"
        $(e.srcElement).html "(show less)"
      when "(show less)"
        $(e.srcElement).html "(show more)"

  onSave: (e) ->
    e.preventDefault()
    @$(".save-categories").attr("disabled", "true")
    if @$(".user-location").val()
      LOAF.categories = @categories
      LOAF.location = @$(".user-location").val()
      @callback.apply @cbContext, @cbParams

  render: ->
    @$("ul.yelp-categories-list").find("ul").hide()
