###
Connection API
Pending to final SPEC
http://www.w3.org/TR/offline-webapps/
http://www.w3.org/TR/2012/WD-netinfo-api-20121129/

@namespace  Device
@class      Gps
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.connection((dvc) ->

  online: (callback) -> dvc.addEvent window, "online", callback

  offline: (callback) -> dvc.addEvent window, "offline", callback

)(Device)
