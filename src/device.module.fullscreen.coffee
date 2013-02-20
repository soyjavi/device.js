###
Audio API (HTML5 Feature)
Pending to final SPEC

@namespace  Device
@class      Audio
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.FullScreen = do ->

  ###
  @todo
  ###
  enable = (e) ->
    e.requestFullscreen?() || e.webkitRequestFullScreen?() || e.requestFullScreen?() || e.mozRequestFullScreen?()

  cancel = (d = document)->
    d.cancelFullScreen?() || d.webkitCancelFullScreen?() || d.mozCancelFullScreen?() || d.exitFullscreen?()

  enabled = (d = document) ->
    d.fullScreen || d.webkitIsFullScreen || d.mozFullScreen

  enable: enable
  cancel: cancel
  enabled: enabled

