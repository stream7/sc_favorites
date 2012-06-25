#= require jquery
#= require jquery_ujs
#= require backbone/sc_favorites
#= require_self

$ ->

  SC.initialize(
    client_id: "f0c59d335804a12938dbc307e33c008e",
    redirect_uri: "http://sc-favorites.herokuapp.com/",
  )

  homeView = new SCFavorites.Views.Home()
  $('#main-container').append homeView.render().el
  # $(".fancy_title").lettering();




