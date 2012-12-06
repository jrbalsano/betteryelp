class LOAF.ListsList
  constructor: (options) ->
    options = if options then options else {}
    @lists = if options.lists then options.lists else []
  
  addLists: (lists) ->
    _.each lists, @addList, @

  addList: (list) ->
    list.id = LOAF.yelpLists.getLists().length + LOAF.customLists.getLists().length
    @lists.push list

  removeList: (list) ->
    @lists = _.without @lists, list

  getLists: ->
    @lists.slice 0

  search: (term) ->
    _.flatten _.map @lists, 
      (list) ->
        list.search(term)
      true
