###
    DeviceJS 0.0.2
    http://

    Copyright (C) 2013 Javi Jiménez Villar (@soyjavi) - Licensed MIT
###

window.Device =

  addEvent: (element, eventName, callback) ->
    if element.addEventListener
      element.addEventListener eventName, callback, false
    else if element.attachEvent
      element.attachEvent "on#{eventName}", callback
    else
      element["on#{eventName}"] = callback

  removeEvent: (element, eventName, callback) ->
    if element.removeEventListener
      element.removeEventListener eventName, callback, false
    else if element.detachEvent
      element.detachEvent "on" + eventName, callback
    else
      element["on#{eventName}"] = null
