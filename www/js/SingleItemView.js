// Generated by CoffeeScript 1.4.0
(function() {

  LOAF.SingleItemView = LOAF.BreadcrumbView.extend({
    tagName: 'div',
    className: 'bcrumbs-single-view',
    current: 'info',
    initialize: function(options) {
      this.title = this.model.get("name");
      return this.initHistory(options);
    },
    render: function() {
      var html;
      html = Mustache.render(LOAF.templates.bcSingleItem, (this.model ? this.model.attributes : {}));
      this.$el.html(html);
      return this.renderHistory();
    },
    events: {
      "click .bcrumbs-single-item-info-link": "showInfo",
      "click .bcrumbs-single-item-notes-link": "showNotes",
      "click .bcrumbs-single-item-lists-link": "showLists",
      "click .bcrumbs-single-item-reviews-link": "showReviews"
    },
    showInfo: function() {
      if (this.current !== 'info') {
        $(".bcrumbs-single-item-section-info").show();
        $(".bcrumbs-single-item-section-notes").hide();
        $(".bcrumbs-single-item-section-lists").hide();
        $(".bcrumbs-single-item-section-reviews").hide();
        $(".bcrumbs-single-item-tab").removeClass('active');
        $(".bcrumbs-single-item-info-link").addClass('active');
      }
      return this.current = 'info';
    },
    showNotes: function() {
      if (this.current !== 'notes') {
        $(".bcrumbs-single-item-section-info").hide();
        $(".bcrumbs-single-item-section-notes").show();
        $(".bcrumbs-single-item-section-lists").hide();
        $(".bcrumbs-single-item-section-reviews").hide();
        $(".bcrumbs-single-item-tab").removeClass('active');
        $(".bcrumbs-single-item-notes-link").addClass('active');
      }
      return this.current = 'notes';
    },
    showLists: function() {
      if (this.current !== 'lists') {
        $(".bcrumbs-single-item-section-info").hide();
        $(".bcrumbs-single-item-section-notes").hide();
        $(".bcrumbs-single-item-section-lists").show();
        $(".bcrumbs-single-item-section-reviews").hide();
        $(".bcrumbs-single-item-tab").removeClass('active');
        $(".bcrumbs-single-item-lists-link").addClass('active');
      }
      return this.current = 'lists';
    },
    showReviews: function() {
      if (this.current !== 'reviews') {
        $(".bcrumbs-single-item-section-info").hide();
        $(".bcrumbs-single-item-section-notes").hide();
        $(".bcrumbs-single-item-section-lists").hide();
        $(".bcrumbs-single-item-section-reviews").show();
        $(".bcrumbs-single-item-tab").removeClass('active');
        $(".bcrumbs-single-item-reviews-link").addClass('active');
      }
      return this.current = 'reviews';
    }
  });

}).call(this);