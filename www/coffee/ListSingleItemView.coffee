LOAF.ListSingleItemView = Backbone.View.extend
  tagName: "div"
  className: "bcrumbs-single-list-item bcrumbs-listing"

  initialize: (options)->
    @current = "none"
    @template = options.template

  events:
    "mouseover .icon-info-sign": "onShowInfo"
    "mouseover .icon-plus": "onShowAdd"
    "mouseover .icon-list": "onShowLists"
    "mouseover .icon-star": "onShowReviews"
    "click .icon-info-sign": "onClickInfo"
    "click .icon-plus": "onClickAdd"
    "click .icon-list": "onClickLists"
    "click .icon-star": "onClickReviews"
    "mouseout .bcrumbs-single-icons": "onExit"

  onClickInfo: ->
    if @current == "info"
      @current = "none"
    else
      @current = "info"

  onClickLists: ->
    if @current == "lists"
      @current = "none"
    else
      @current = "lists"

  onClickReviews: ->
    if @current == "reviews"
      @current = "none"
    else
      @current = "reviews"

  onClickAdd: ->

  onShowInfo: ->
    @$(".img-overlay-text >span").hide()
    @$(".img-overlay-text").show()
    @$(".img-overlay").show()
    @$(".bc-list-view-single-info").show()

  onShowAdd: ->
    @$(".img-overlay-text >span").hide()
    @$(".img-overlay-text").show()
    @$(".img-overlay").show()
    @$(".bc-list-view-single-add").show()

  onShowLists: ->
    @$(".img-overlay-text >span").hide()
    @$(".img-overlay-text").show()
    @$(".img-overlay").show()
    @$(".bc-list-view-single-lists").show()

  onShowReviews: ->
    @$(".img-overlay-text >span").hide()
    @$(".img-overlay-text").show()
    @$(".img-overlay").show()
    @$(".bc-list-view-single-reviews").show()

  onExit: ->
    if @current == "none"
      @$(".img-overlay-text").hide()
      @$(".img-overlay").hide()

  render: ->
    @$el.html Mustache.render @template, @model.attributes
    @
