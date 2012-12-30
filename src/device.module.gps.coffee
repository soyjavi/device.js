###
Geolocation API
Pending to final SPEC, now it's a Phonegap Wrapper
http://www.w3.org/TR/geolocation-API/

@namespace  Device
@class      Gps
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Gps = ((dvc, undefined_) ->
  _position = null
  _watcher = null
  CALLBACK =
    success: null
    error: null

  GPS_OPTIONS =
    enableHighAccuracy: false
    timeout: 10000
    maximumAge: 60000

  get = (callbacks, options) ->
    if _isReady()
      _bindCallbacks callbacks
      navigator.geolocation.getCurrentPosition _success, _error, options

  watch = (callbacks, options) ->
    if _isReady()
      _bindCallbacks callbacks
      _watcher = navigator.geolocation.watchPosition(_success, _error, options)

  position = ->
    _position

  stop = ->
    _clearPosition()

  _isReady = ->
    if navigator.geolocation
      _clearPosition()
      true
    else
      console.error "Lungo.Device.Gps [ERROR]: navigator.geolocation is innacesible."
      false

  _clearPosition = ->
    _position = null
    if _watcher
      navigator.geolocation.clearWatch _watcher
      _watcher = null

  _bindCallbacks = (callbacks) ->
    CALLBACK.success = (callbacks.success or null)
    CALLBACK.error = (callbacks.error or null)

  _success = (position) ->
    _position = position.coords
    CALLBACK.success.call CALLBACK.success, position

  _error = (error) ->
    _clearPosition()
    CALLBACK.error.call CALLBACK.error, error

  get: get
  watch: watch
  position: position
  address: address
  stop: stop

)(Device)
