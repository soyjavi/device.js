###
Audio API (HTML5 Feature)
http://dev.w3.org/2011/webrtc/editor/getusermedia.html

@namespace  Device
@class      Camera
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Camera = do (dvc = Device) ->

  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia
  _instance = null

  ###
  @todo
  @method get
  @param  {object}    audio/video booleans
          {function}  Success callback
          {function}  Error callback
  ###
  get = (options, success, error) ->
    if navigator.getUserMedia?
      _instance =  navigator.getUserMedia options, (stream) ->
          success?.call(success, stream)
        , (error) -> _failed error
    else
      _failed "Device no available"

  _failed = (error) ->
    console.error "Device.Camera [ERROR] - ", error

  get: get
