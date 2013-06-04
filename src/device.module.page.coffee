###
Page Visibility
W3C Recommendation 14 May 2013
http://www.w3.org/TR/page-visibility/

@namespace  Device
@class      Page
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Page = do (dvc = Device) ->

  document.visibilityState = document.visibilityState || document.webkitVisibilityState
  document.hidden = document.hidden || document.webkitHidden

  _on =
    hidden    : null
    visible   : null

  ###
  @todo
  @method state
  @return {object} State of current page
  ###
  state = ->
    hidden: document.hidden
    state: document.visibilityState


  ###
  @todo
  @method hide
  @param  {function} Callback
  ###
  hide = (callback) -> _on.hidden = callback


  ###
  @todo
  @method visible
  @param  {function} Callback
  ###
  visible = (callback) -> _on.visible = callback

  init = do ->
    event_name = if document.webkitVisibilityState then "webkitvisibilitychange" else "visibilitychange"
    dvc.addEvent document, event_name, =>
      _on[document.visibilityState]?.call _on[document.visibilityState]

  state   : state
  hide    : hide
  visible : visible
