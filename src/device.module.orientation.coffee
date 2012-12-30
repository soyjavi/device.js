###
Orientation Events API (HTML5 Feature)
DOM events that provide information about the physical orientation and motion of a hosting device.
http://www.w3.org/TR/orientation-event/

@namespace  Device
@class      Camera
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Orientation = (() ->
  EVENTS =
    ORIENTATION: "deviceorientation"
    MOTION: "devicemotion"
    COMPASS_CALIBRATION: "compassneedscalibration"

  onChange = (callback) ->
    _addEvent EVENTS.ORIENTATION, callback

  onMotion = (callback) ->
    _addEvent EVENTS.MOTION, callback

  onNeedsCalibration = (callback) ->
    _addEvent EVENTS.COMPASS_CALIBRATION, callback

  _addEvent = (event, callback) ->

    #@todo: Cross-browser: IE fix
    window.addEventListener event, ((event) ->
      callback.apply callback, event
    ), true

  onChange: onChange
  onMotion: onMotion
  onNeedsCalibration: onNeedsCalibration

)()
