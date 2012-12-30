###
    DeviceJS 0.0.1
    http://tapquo.com

    Copyright (C) 2011,2012 Javi Jiménez Villar (@soyjavi)
###

Device =
  addEvent: (element, event, callback) ->
    if element.addEventListener
      element.addEventListener event, callback, false
    else if element.attachEvent
      element.attachEvent "on#{event}", callback
    else
      element["on#{event}"] = callback

window.Device = Device
