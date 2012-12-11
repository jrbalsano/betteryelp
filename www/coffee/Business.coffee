LOAF.Business = Backbone.Model.extend
  initialize: ->
    current_categories = ['active', 'arts', 'food', 'hotelstravel', 'localflavor', 'localservices', 'nightlife', 'restaurants', 'shopping', 'yoga', 'icecream', 'museums']
    img_name_append = @.get("categories")[0][1]
    if img_name_append not in current_categories
      @.set("cover_image_url", "http://placehold.it/960x300&text=Business+Image+Missing+_#{img_name_append}")
    else
  	  @.set("cover_image_url", "img/cat_#{img_name_append}.jpg")

  listIds: []

  addList: (list) ->
    unless _.contains @listIds, list.id
      @listIds.push list.id
      @trigger "change", @listIds

  removeList: (list) ->
    @listIds = _.without @listIds, list.id
    @trigger "change", @listIds

  search: (term) ->
    term = term.toUpperCase()
    _.some @attributes, (value, key) ->
      switch key
        when "name" then value.toUpperCase().indexOf(term) >= 0
        when "categories" then _.some value, (cat) ->
          cat[0].toUpperCase().indexOf(term) >= 0
        else
          false
