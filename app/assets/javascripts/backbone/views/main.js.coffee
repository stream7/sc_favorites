class SCFavorites.Views.Main extends Backbone.View
  template: JST["backbone/templates/main"]

  events: 
    'click a#user-favorites' : 'favorites'
    'click a#user-tracks' : 'tracks'
    'click a#user-play-favorites' : 'playFavorites'
    'click a#user-play-tracks' : 'playTracks'
    'click a#widget-next' : 'next'
    'click a#widget-prev' : 'prev'
    

  initialize: ->
    @user = @options.user

  next: (event) ->
    event.preventDefault()
    SCFavorites.Widget.next()

  prev: (event) ->
    event.preventDefault()
    SCFavorites.Widget.prev()

  favorites: (event) =>
    new SCFavorites.Views.List(
      endPoint: "/users/#{@user.id}/favorites"
      listingViewKey: 'track'
      listingViewClass: SCFavorites.Views.Track
      el: '#results'
    ).fetchAndRender(event)

  tracks: (event) =>
    new SCFavorites.Views.List(
      endPoint: "/users/#{@user.id}/tracks"
      listingViewKey: 'track'
      listingViewClass: SCFavorites.Views.Track
      el: '#results'
    ).fetchAndRender(event)

  playFavorites: (event) =>
    event.preventDefault()
    @playAll('favorites')

  playTracks: (event) =>
    event.preventDefault()
    @playAll('tracks')

  playAll: (type) =>
    SCFavorites.Widget.loadURL @playAllURL(type)
    $('#widget-controls').show()

  playAllURL: (type) =>
    if type == 'favorites'
      "http://api.soundcloud.com/users/#{@user.permalink}/favorites&show_artwork=true&auto_play=true"
    else
      "http://api.soundcloud.com/users/#{@user.permalink}&show_artwork=true&auto_play=true"

  render: ->
    $(@el).html @template(user: @user)
    @ 