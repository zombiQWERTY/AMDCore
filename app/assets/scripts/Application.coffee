"use strict"

requirejs.config
	baseUrl: "javascripts/"
	paths  :
		jquery    : "libs/jquery"
		underscore: "libs/underscore"
		Mediator  : "Mediator"
		Facade    : "Facade"
		modules   : "modules"


define ["Facade"], (Facade) ->
	Facade.Modules.Load("Start", "modules/Start").done ->
		if Facade.Modules.Has "Start"
			Facade.Modules.Get "Start"
		else
			console.log "Error with initialization."
		return
