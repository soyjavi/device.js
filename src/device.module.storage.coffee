###
Web Storage (HTML5 Feature)
Candidate Recommendation
http://www.w3.org/TR/webstorage/

@namespace  Device
@class      Storage
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Storage = do ->
  STORAGE =
    PERSISTENT: "localStorage"
    SESSION: "sessionStorage"


  ###
  LocalStorage manager
  @method persistent
  @param  {string} Key
  @param  {object} Value
  @return {string} If no value assigned returns the value of established key
  ###
  local = (key, value) -> _handler STORAGE.PERSISTENT, key, value


  ###
  Wrapper for SessionStorage
  @method session
  @param  {string} Key
  @param  {object} Value
  @return {string} If no value assigned returns the value of established key
  ###
  session = (key, value) -> _handler STORAGE.SESSION, key, value


  _handler = (storage, key, value) ->
    storage = window[storage]
    if value
      _saveKey storage, key, value
    else if value is null
      _removeKey storage, key
    else
      _getKey storage, key

  _saveKey = (storage, key, value) -> storage.setItem key, JSON.stringify(value)

  _removeKey = (storage, key) -> storage.removeItem key

  _getKey = (storage, key) -> JSON.parse storage.getItem(key)

  local: local
  session: session


