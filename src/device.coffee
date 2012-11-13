###
    Device 0.0.1
    http://tapquo.com

    Copyright (C) 2011,2012 Javi Jiménez Villar (@soyjavi)

###

Events =
    bind: (ev, callback) ->
        evs = ev.split(' ')
        calls = @hasOwnProperty('_callbacks') and @_callbacks or= {}

        for name in evs
            calls[name] or= []
            calls[name].push(callback)
        @

    trigger: (args...) ->
        ev = args.shift()

        list = @hasOwnProperty('_callbacks') and @_callbacks?[ev]
        return unless list

        for callback in list
            if callback.apply(@, args) is false
                break
        true

    unbind: (ev, callback) ->
        unless ev
            @_callbacks = {}
            return @

        list = @_callbacks?[ev]
        return @ unless list

        unless callback
            delete @_callbacks[ev]
            return @

        for cb, i in list when cb is callback
            list = list.slice()
            list.splice(i, 1)
            @_callbacks[ev] = list
            break
        @

moduleKeywords = ['included', 'extended']

class Module
    @include: (obj) ->
        throw new Error('include(obj) requires obj') unless obj
        for key, value of obj when key not in moduleKeywords
            @::[key] = value

        included = obj.included
        included.apply(this) if included
        @

    @extend: (obj) ->
        throw new Error('extend(obj) requires obj') unless obj
        for key, value of obj when key not in moduleKeywords
            @[key] = value

        obj.extended?.apply(this)
        @

    @proxy: (method) ->
        => method.apply(@, arguments)

    proxy: (method) ->
        => method.apply(@, arguments)

    delay: (method, timeout) ->
        setTimeout(@proxy(method), timeout || 0)

    constructor: ->
        @init?(args...)

# Globals
Device = @Device = {}
Device.version     = "0.0.1"
Device.Events      = Events
Device.Module      = Module

# Global events
Module.extend.call(Device, Events)
