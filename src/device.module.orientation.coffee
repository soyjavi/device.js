###
Orientation Events API (HTML5 Feature)
DOM events that provide information about the physical orientation and motion of a hosting device.
http://www.w3.org/TR/orientation-event/

@namespace  Device
@class      Orientation
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Orientation = do (dvc = Device) ->

  EVENT =
    ORIENTATION: "deviceorientation"
    MOTION: "devicemotion"
    COMPASS_CALIBRATION: "compassneedscalibration"

  window.Orientation = window.DeviceOrientationEvent or window.OrientationEvent
  window.Motion = window.DeviceMotionEvent

  change = (callback) ->
    dvc.addEvent window, EVENT.ORIENTATION, (event) ->

      if event.webkitCompassHeading
        heading = event.webkitCompassHeading + window.orientation

      if window.DeviceOrientationEvent
        x = event.gamma
        y = event.beta
        z = null
        direction = event.alpha
      else if window.OrientationEvent
        x = event.x * 90
        y = event.y * -90
        z = event.z
        direction = null
      coordinates =
        x: Math.round(x)
        y: Math.round(y)
        z: z
        direction: Math.round(direction)
        heading: heading
      callback.call this, coordinates

  motion = (callback) ->
    dvc.addEvent window, EVENT.MOTION, (event) ->
      acceleration = event.accelerationIncludingGravity
      acceleration = event.acceleration
      coordinates =
        x: acceleration.x.toFixed(2)
        y: acceleration.y.toFixed(2)
        z: acceleration.z.toFixed(2)
      callback.call this, coordinates

  onNeedsCalibration = (callback) ->
    dvc.addEvent window, EVENT.COMPASS_CALIBRATION, callback

  change: change
  motion: motion
  onNeedsCalibration: onNeedsCalibration

