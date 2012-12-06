LOAF.CustomList = BackBone.Collection.extend
  initialize: (models, options) ->
    options = if options then options else {}
    @name = options.name
    @isAllCrumbs = options.isAllCrumbs || false
    @id = options.id

  model: LOAF.Business

  search: (term) ->
    @filter (model) ->
      model.search(term)

  toJSON: ->
    object =
      models: Backbone.Collection.prototype.toJSON.call this
      name: @name
      isAllCrumbs: @isAllCrumbs
      id: @id
