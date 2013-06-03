###
Battery Status API
http://www.w3.org/TR/battery-status/

@namespace  Device
@class      Battery
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Battery = do (dvc = Device) ->

  EVENT =
    CHARGING          :   "chargingchange"
    CHARGING_TIME     :  "chargingtimechange"
    DISCHARGING_TIME  : "dischargingtimechange"
    LEVEL             : "levelchange"

  navigator.battery = navigator.battery || navigator.webkitBattery || navigator.mozBattery

  ###
  @todo
  @method get
  @param  {object}    audio/video booleans
          {function}  Success callback
          {function}  Error callback
  ###
  status = ->
    if navigator.battery?
      do _instance
    else
      _failed "Device no available"


  onCharging = (callback) -> _event EVENT.CHARGING, callback

  onChargingTime = (callback) -> _event EVENT.CHARGING_TIME, callback

  onDischargingTime = (callback) -> _event EVENT.DISCHARGING_TIME, callback

  onLevel = (callback) -> _event EVENT.LEVEL, callback

  _event = (event, callback) ->
    dvc.addEvent navigator.battery, event, => callback?.call callback, _instance()

  _instance = ->
    level           : Math.floor(navigator.battery.level * 100)
    charging        : navigator.battery.charging
    chargingTime    : navigator.battery.chargingTime
    dischargingTime : navigator.battery.chargingTime

  _failed = (error) ->
    console.error "Device.Battery [ERROR] - ", error

  status            : status
  onCharging        : onCharging
  onChargingTime    : onChargingTime
  onDischargingTime : onDischargingTime
  onLevel           : onLevel
