/* DeviceJS v0.1.0 - 2/19/2013
   http://
   Copyright (c) 2013 Tapquo S.L. - Licensed GPLv3, Commercial */
var Device;Device={addEvent:function(n,e,t){return n.addEventListener?n.addEventListener(e,t,!1):n.attachEvent?n.attachEvent("on"+e,t):n["on"+e]=t}},window.Device=Device,Device.Audio=function(){var n,e,t,i,r;return t=document.createElement("audio"),r=document.createElement("audio"),n=function(n){return n?(i(r,n),t.addEventListener("ended",function(){return this.currentTime=0},!1)):t.pause()},e=function(n){return i(r,n)},i=function(n,e){return n.setAttribute("src",e),n.play()},{background:n,play:e}}(),Device.connection(function(n){return{online:function(e){return n.addEvent(window,"online",e)},offline:function(e){return n.addEvent(window,"offline",e)}}})(Device),Device.Gps=function(){var n,e,t,i,r,o,c,u,a,l,v,f,s;return v=null,s=null,n={success:null,error:null},e={enableHighAccuracy:!1,timeout:1e4,maximumAge:6e4},t=function(n,e){return l()?(c(n),navigator.geolocation.getCurrentPosition(f,a,e)):void 0},o=function(n,e){return l()?(c(n),s=navigator.geolocation.watchPosition(f,a,e)):void 0},i=function(){return v},r=function(){return u()},l=function(){return navigator.geolocation?(u(),!0):(console.error("Lungo.Device.Gps [ERROR]: navigator.geolocation is innacesible."),!1)},u=function(){return v=null,s?(navigator.geolocation.clearWatch(s),s=null):void 0},c=function(e){return n.success=e.success||null,n.error=e.error||null},f=function(e){return v=e.coords,n.success.call(n.success,e)},a=function(e){return u(),n.error.call(n.error,e)},{get:t,watch:o,position:i,address:address,stop:r}}(Device),Device.Notification=function(){var n,e,t,i;return n=function(n,e,t,i){return navigator.notification.alert(n,e,t,i)},t=function(n,e,t,i){return navigator.notification.confirm(n,e,t,i)},e=function(n){return navigator.notification.beep(n)},i=function(n){return navigator.notification.vibrate(n)},{alert:n,confirm:t,beep:e,vibrate:i}}(),Device.Orientation=function(){var n,e,t,i,r;return n={ORIENTATION:"deviceorientation",MOTION:"devicemotion",COMPASS_CALIBRATION:"compassneedscalibration"},e=function(e){return r(n.ORIENTATION,e)},t=function(e){return r(n.MOTION,e)},i=function(e){return r(n.COMPASS_CALIBRATION,e)},r=function(n,e){return window.addEventListener(n,function(n){return e.apply(e,n)},!0)},{onChange:e,onMotion:t,onNeedsCalibration:i}}();