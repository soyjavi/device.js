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
  @method status
  @return {object}    Battery status
  ###
  status = ->
    if navigator.battery?
      do _instance
    else
      _failed "Device no available"


  ###
  @todo
  @method onCharging
  @param  {object}    audio/video booleans
          {function}  Success callback
          {function}  Error callback
  @return {object}    Battery status

  ###
  onCharging = (callback) -> _event EVENT.CHARGING, callback


  ###
  @todo
  @method onChargingTime
  @param  {function}  Success callback
  @return {object}    Battery status
  ###
  onChargingTime = (callback) -> _event EVENT.CHARGING_TIME, callback


  ###
  @todo
  @method onDischargingTime
  @param  {function}  Success callback
  @return {object}    Battery status
  ###
  onDischargingTime = (callback) -> _event EVENT.DISCHARGING_TIME, callback


  ###
  @todo
  @method onLevel
  @param  {function}  Success callback
  @return {object}    Battery status
  ###
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
