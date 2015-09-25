"use strict"

define ["Facade", "modules/Start/view/Start"], (Facade, View) ->
	class Controller
		constructor: ->

		data  : {} # Data store
		events:
			onInitialize: ->
				StartView = new View "Нажми на меня (Start)"
				console.log "Your application is initialized"
				click()
				return

		click = ->
			$(".changeView").on "click", ->
				if Facade.Modules.Has "EndCtrl"
					Facade.Modules.Broadcast "EndCtrl", "Initialize"
				else
					Facade.Modules.Load("EndCtrl", "modules/End/controller/End").done ->
						console.log "Loaded \"EndCtrl\"."
						Facade.Modules.Broadcast "EndCtrl", "Initialize"
						return
			return

	new Controller().events
