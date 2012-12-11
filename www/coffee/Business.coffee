LOAF.Business = Backbone.Model.extend
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
