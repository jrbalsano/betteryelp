LOAF.CustomList = BackBone.Collection.extend
  initialize: (models, options) ->
    options = if options then options else {}
    @name = options.name
    @isAllCrumbs = options.isAllCrumbs

  model: LOAF.Business

  search: (term) ->
    @filter (model) ->
      model.search(term)
