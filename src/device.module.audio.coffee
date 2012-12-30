###
Audio API (HTML5 Feature)
Pending to final SPEC

@namespace  Device
@class      Audio
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Audio = (() ->
  _background = document.createElement("audio")
  _sound = document.createElement("audio")

  ###
  Plays music in background with automatic rewind.
  @method background
  @param  {string} Source of sound file
  ###
  background = (source) ->
    if source
      _setSourceAndPlay _sound, source
      _background.addEventListener "ended", (->
        @currentTime = 0
      ), false
    else
      _background.pause()


  ###
  Play a given sound
  @method play
  @param  {string} Source of sound file
  ###
  play = (source) ->
    _setSourceAndPlay _sound, source

  _setSourceAndPlay = (container, source) ->
    container.setAttribute "src", source
    container.play()

  background: background
  play: play
)()
