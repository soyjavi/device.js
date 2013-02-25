###
Connection API
Pending to final SPEC
http://www.w3.org/TR/offline-webapps/
http://www.w3.org/TR/2012/WD-netinfo-api-20121129/

@namespace  Device
@class      Connection
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Connection = do (dvc = Device) ->

  online = (callback) -> dvc.addEvent window, "online", callback

  offline = (callback) -> dvc.addEvent window, "offline", callback

  online: online
  offline: offline
