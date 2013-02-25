###
Alarms API (HTML5 Feature)
Pending to final SPEC

@namespace  Device
@class      Alarms
@author     David Basoko <basoko@gmail.com> || @davidbasoko
###

Device.Alarm = do (dvc = Device) ->
  EVENT = "alarm"

  navigator.alarms = navigator.alarms || navigator.mozAlarms
  _alarmsHandler = navigator.alarms?.addEventListener || navigator.mozSetMessageHandler

  ###
  Return all aplication's alarms.
  @method all
  @param  {function} Optional callback to set the success event handler
  @param  {function} Optional callback to set the error event handler
  ###
  all = (success, error) ->
    request = navigator.alarms.all()
    _setRequestHandlers request, success, error


  ###
  Adds an alarm.
  @method add
  @param  {date}     Date indicating when the alarm should trigger
  @param  {boolean}  Boolean to specify if is needed to ignore the timezone information of that Date object
  @param  {object}   Optionally data passed as JSON for that alarm
  @param  {function} Optional callback to set the success event handler
  @param  {function} Optional callback to set the error event handler
  ###
  add = (date, respectTimezone, data, success, error) ->
    timezone = if respectTimezone then 'respectTimezone' else 'ignoreTimezone'
    request = navigator.alarms.add date, timezone, data
    _setRequestHandlers request, success, error


  ###
  Removes an alarm.
  @method remove
  @param  {string}  The alarm idenftifier
  @param  {function} Optional callback to set the success event handler
  @param  {function} Optional callback to set the error event handler
  ###
  remove = (alarmId, success, error) ->
    request = navigator.alarms.remove alarmId
    _setRequestHandlers request, success, errorr


  ###
  Add a callback handler to listen when an alarm goes off.
  @method event
  @param  {function} Callback handler
  ###
  event = (callback) -> if _alarmsHandler then _alarmsHandler EVENT, callback

  _setRequestHandlers = (request, success, error) ->
    request?.onsuccess = success
    request?.onerror = error
    request

  add: add
  remove: remove
  all: all
  event: event
