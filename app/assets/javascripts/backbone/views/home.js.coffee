class SCFavorites.Views.Home extends Backbone.View
  template: JST["backbone/templates/home"]

  events: 
    'click a#connect' : 'connect'

  connect: (event)->
    event.preventDefault()
    SC.connect ()->
      SC.get '/me', (user) ->
        SCFavorites.User = user

        mainView = new SCFavorites.Views.Main(user: SCFavorites.User)
        $('#main-container').html mainView.render().el

        SCFavorites.Widget = new SCFavorites.Libs.Widget('#sc-widget')

        SC.get "/users/#{user.id}/favorites", limit: 1, (favorites) -> 
          SCFavorites.Widget.loadTrack favorites[0].id if favorites.length

        new SCFavorites.Views.List(
            endPoint: "/users/#{user.id}/followings"
            listingViewKey: 'user'
            listingViewClass: SCFavorites.Views.Following
            el: '#followings'
        ).fetchAndRender(event)


  render: ->
    $(@el).html @template()
    @ 