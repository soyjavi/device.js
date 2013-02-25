###
    DeviceJS 0.0.2
    http://

    Copyright (C) 2013 Javi Jiménez Villar (@soyjavi) - Licensed MIT
###

window.Device =

  addEvent: (element, event, callback) ->
    if element.addEventListener
      element.addEventListener event, callback, false
    else if element.attachEvent
      element.attachEvent "on#{event}", callback
    else
      element["on#{event}"] = callback

  removeEvent: (element, event, callback) ->
    if element.removeEventListener
      element.removeEventListener event, callback, false
    else if element.detachEvent
      element.detachEvent "on" + event, callback
    else
      element["on#{event}"] = null
