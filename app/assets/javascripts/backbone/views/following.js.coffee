class SCFavorites.Views.Following extends Backbone.View
  template: JST["backbone/templates/following"]
  className: 'following clearfix'

  events:
    'click a.favorites' : 'favorites'
    'click a.tracks' : 'tracks'
    'click a.play-tracks' : 'playAllTracks'
    'click a.play-favorites' : 'playAllFavorites'

  initialize: ->
    @user = @options.user

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

  playAllTracks: (event) =>
    event.preventDefault()
    @playAll('tracks')

  playAllFavorites: (event) =>
    event.preventDefault()
    @playAll('favorites')

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