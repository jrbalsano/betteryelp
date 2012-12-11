LOAF.CustomList = Backbone.Collection.extend
  initialize: (models, options) ->
    options = if options then options else {}
    @name = options.name
    @isAllCrumbs = options.isAllCrumbs || false
    @id = options.id
    @.on "add", @onAdd, @
    @.on "remove", @onRemove, @

  model: LOAF.Business

  onAdd: (business) ->
    business.addList @
    console.log "added #{business.attributes.id} to #{@name}"
    LOAF.appView.saveApplication()

  onRemove: (business) ->
    business.removeList @
    console.log "removed #{business.attributes.id} from #{@name}"
    LOAF.appView.saveApplication()

  search: (term) ->
    @filter (model) ->
      model.search(term)

  toJSON: ->
    object =
      models: Backbone.Collection.prototype.toJSON.call this
      name: @name
      isAllCrumbs: @isAllCrumbs
      id: @id
