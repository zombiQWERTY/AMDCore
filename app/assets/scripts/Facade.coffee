"use strict"

define ["Mediator"], (Mediator) ->
	Modules:
		Load     : (name, component, replaceDuplicate) ->
			Mediator.load name, component, replaceDuplicate
		Add      : (name, component, replaceDuplicate) ->
			Mediator.add "add", name, component, replaceDuplicate
		Get      : (name) ->
			Mediator.get name
		Has      : (name) ->
			Mediator.has name
		Remove   : (name) ->
			Mediator.remove name
		Broadcast: (component, event, args, source) ->
			Mediator.broadcast component, event, args, source
