###
Notification API (HTML5 Feature)
Pending to final SPEC

@namespace  Device
@class      Notification
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Notification = (() ->

  ###
  Shows a custom alert or dialog box.

  @method alert

  @param {string}   Dialog message
  @param {Function} Callback to invoke when alert dialog is dismissed.
  @param {string}   Dialog title (Optional, Default: "Alert")
  @param {string}   Button name (Optional, Default: "OK")
  ###
  alert = (message, callback, title, buttonName) ->
    navigator.notification.alert message, callback, title, buttonName


  ###
  Shows a customizable confirmation dialog box.

  @method confirm

  @param {string}   Dialog message @ToDo
  @param {function} Callback to invoke with index of button pressed (1, 2 or 3).
  @param {string}   Dialog title (Optional, Default: "Confirm")
  @param {string}   Comma separated string with button labels (Optional, Default: "OK,Cancel")
  ###
  confirm = (message, callback, title, buttonLabels) ->
    navigator.notification.confirm message, callback, title, buttonLabels


  ###
  The device will play a beep sound.

  @method beep

  @param {number} The number of times to repeat the beep
  ###
  beep = (times) ->
    navigator.notification.beep times


  ###
  Vibrates the device for the specified amount of time.

  @method vibrate

  @param {number} Milliseconds to vibrate the device. 1000 milliseconds equals 1 second
  ###
  vibrate = (milliseconds) ->
    navigator.notification.vibrate milliseconds

  alert: alert
  confirm: confirm
  beep: beep
  vibrate: vibrate
)()
