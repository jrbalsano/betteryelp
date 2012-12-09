LOAF.Business = Backbone.Model.extend
  #cover_image_url: 'none'

  initialize: ->
  	img_name_append = @.get("categories")[0][1]
  	@.set("cover_image_url") = "img/cat_#{img_name_append}.jpg"

  search: (term) ->
    term = term.toUpperCase()
    _.some @attributes, (value, key) ->
      switch key
        when "name" then value.toUpperCase().indexOf(term) >= 0
        when "categories" then _.some value, (cat) ->
          cat[0].toUpperCase().indexOf(term) >= 0
        else
          false
