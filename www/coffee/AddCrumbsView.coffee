LOAF.AddCrumbsView = LOAF.BreadcrumbView.extend
  tagName: 'div'
  className: 'bcrumbs-yelp-view'

  render: ->
    categoryHtml = ""
    _.each LOAF.yelpLists.getLists(), (list) ->
      obj =
        name: list.category,
        image1: if list.size() > 0 then list.models[0].get("image_url")
        image2: if list.size() > 1 then list.models[1].get("image_url")
        image3: if list.size() > 2 then list.models[2].get("image_url")
        id: list.id
      categoryHtml += Mustache.render LOAF.templates.bcListViewList, obj
    @$(".bcrumbs-browse-items").html categoryHtml
    @
