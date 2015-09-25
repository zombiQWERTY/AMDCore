"use strict"

requirejs.config
	baseUrl: "javascripts/"
	paths  :
		text      : "libs/text"
		jquery    : "libs/jquery"
		underscore: "libs/underscore"
		Mediator  : "Mediator"
		Facade    : "Facade"
		modules   : "modules"
		templates : "../views"


define ["Facade"], (Facade) ->
	Facade.Modules.Load("StartCtrl", "modules/Start/controller/Start").done ->
		if Facade.Modules.Has "StartCtrl"
			Facade.Modules.Broadcast "StartCtrl", "Initialize"
		else
			console.log "Error with \"StartCtrl\"."
		return
