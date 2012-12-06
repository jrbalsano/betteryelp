class LOAF.ListsList
  constructor: (options) ->
    @lists = []
    _.each options.lists, @lists.push if options && options.lists
  
  addLists: (lists) ->
    _.each(lists, @addList)

  addList: (list) ->
    @lists.push list
    list.id = LOAF.yelpLists.getLists().length + LOAF.yelpLists.getLists().length

  removeList: (list) ->
    @lists = _.without @lists, list

  getLists: ->
    @lists.slice 0

  search: (term) ->
    _.flatten _.map @lists, 
      (list) ->
        list.search(term)
      true
