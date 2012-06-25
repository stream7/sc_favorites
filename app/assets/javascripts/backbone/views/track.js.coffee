class SCFavorites.Views.Track extends Backbone.View
  template: JST["backbone/templates/track"]
  className: 'track clearfix'
  events: 
    'click a.play' : 'play'

  initialize: ->
    @track = @options.track
    @customClass = @options.customClass

  play: (event) =>
    event.preventDefault()
    SCFavorites.Widget.loadTrack @track.id, true
    $('#widget-controls').hide()

  render: =>
    $(@el).addClass(@customClass) if @customClass
    $(@el).html @template(track: @track)
    @ 