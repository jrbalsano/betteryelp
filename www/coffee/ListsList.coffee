class LOAF.ListsList
  constructor: (options) ->
    @lists = []
    _.each options.lists, @lists.push if options && options.lists

  addList: (list) ->
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
