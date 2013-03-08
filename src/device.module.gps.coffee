###
Geolocation API
Pending to final SPEC, now it's a Phonegap Wrapper
http://www.w3.org/TR/geolocation-API/

@namespace  Device
@class      Gps
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Gps = do (dvc = Device) ->
  _position = null
  _watcher = null
  CALLBACK =
    success: null
    error: null

  GPS_OPTIONS =
    enableHighAccuracy: false
    timeout: 10000
    maximumAge: 60000

  get = (onSuccess, onError, options) ->
    if _isReady()
      navigator.geolocation.getCurrentPosition ((position) ->
        _call onSuccess, position
      ), ((error) -> onError.call onError, error), options


  watch = (onSuccess, onError, options) ->
    if _isReady()
      _watcher = navigator.geolocation.watchPosition ((position) ->
        _call onSuccess, position
      ), ((error) -> onError.call onError, error), options

  _call = (callback, position) ->
    _position = position.coords
    _position.accuracy = Math.round _position.accuracy
    _position.altitude = Math.round _position.altitude
    callback.call callback.call, _position

  position = -> _position

  stop = -> _clearPosition()

  _isReady = ->
    if navigator.geolocation
      _clearPosition()
      true
    else
      console.error "Device.Gps [ERROR]: navigator.geolocation is innacesible."
      false

  _clearPosition = ->
    _position = null
    if _watcher
      navigator.geolocation.clearWatch _watcher
      _watcher = null

  get: get,
  watch: watch,
  position: position,
  stop: stop
