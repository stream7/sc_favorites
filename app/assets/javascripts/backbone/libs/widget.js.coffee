class SCFavorites.Libs.Widget
  constructor: (@selector) ->
    @initialized = false

  next: =>
    @widget.next()

  prev: =>
    @widget.prev()    

  loadTrack: (trackId, autoPlay = false) =>
    @loadWidget @trackURL(trackId)

    if @initialized
      @widget.load @trackURL(trackId, autoPlay)

  loadURL: (url) =>
    @loadWidget url

    if @initialized
      @widget.load url

  trackURL: (trackId, autoPlay = false) ->
    url = "http://api.soundcloud.com/tracks/#{trackId}&show_artwork=true"
    url += "&auto_play=true" if autoPlay
    url 

  loadWidget: (url) =>
    return if @widget

    $(@selector).attr 'src', "http://w.soundcloud.com/player/?url=#{url}"
    @widget = SC.Widget $(@selector)[0]
    @widget.bind SC.Widget.Events.READY, () =>
      @initialized = true