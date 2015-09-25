"use strict"

define ["Facade", "modules/End/view/End"], (Facade, View) ->
	class Controller
		constructor: ->

		data  : {} # Data store
		events:
			onInitialize: ->
				EndView = new View "Нажми на меня (End)"
				console.log "\"EndCtrl\" initialized"
				click()
				return

		click = ->
			$(".changeView").on "click", ->
				if Facade.Modules.Has "StartCtrl"
					Facade.Modules.Broadcast "StartCtrl", "Initialize"
				else
					console.log "\"StartCtrl\" is not loaded yet."
				return
			return

	new Controller().events
