class SCFavorites.Views.List extends Backbone.View
  events: 
    'click a.more' : 'fetchAndRender'

  initialize: ->
    @listings = @options.listings || []
    @customClass = @options.customClass
    @endPoint = @options.endPoint
    @listingViewClass = @options.listingViewClass
    @listingViewKey = @options.listingViewKey
    @hasMore = true

  fetchAndRender: (event) =>
    event.preventDefault() if event
    SC.get @endPoint, offset: @offset(), (listings) =>
      @listings = @listings.concat listings
      @hasMore = false if listings.length < 50
      @render()

  offset: => 
    parseInt(@listings.length / 50, 10) * 50

  render: =>
    $(@el).empty()

    if @listings.length
      for listing in @listings
        options = {customClass: @customClass}
        options[@listingViewKey] = listing
        listingView = new @options.listingViewClass options
        $(@el).append listingView.render().el
      $(@el).append '<a href="#" class="btn btn-info more">Load more</a>' if @hasMore
    else
      $(@el).html "<p>No #{@listingViewKey}s found!</p>"
    @