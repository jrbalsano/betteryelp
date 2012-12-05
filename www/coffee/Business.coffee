LOAF.Business = Backbone.Model
  search: (term) ->
    _.some @attributes, (value, key) ->
      switch key
        when "name" then value.indexOf(term) > 0
        when "categories" then _.some value, (cat) ->
          cat.indexOf(term) > 0
        else
          false
