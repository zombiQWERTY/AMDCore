"use strict"

define ["jquery"], ($) ->
	Mediator = do ->

		components = []

		broadcast = (component, event, args, source = ->) ->
			if !event
				return
			args = args or []
			if typeof components[component]["on" + event] == "function"
				try
					components[component]["on" + event].apply components[component], args
					source()
				catch error
					throw ["Mediator error.", event, args, components[component], source, error].join " "
			return

		addComponent = (type, name, component, replaceDuplicate = true) ->
			if name of components
				if replaceDuplicate
					removeComponent name, component
					message = "Module \"#{name}\" is reloaded."
				else
					throw new Error "Mediator name conflict: #{name}"
			if type == "add"
				components[name] = component
				console.log "Component \"#{name}\" is initialized."
			return

		reloads  = 1
		attempts = 5
		addModule = (name, component, replaceDuplicate = true) ->
			addComponent "load", name, component, replaceDuplicate
			Deferred = $.Deferred()
			require component.split(), (content) ->
				console.log "Module \"#{name}\" is loaded after #{reloads} attempts."
				reloads = 1
				components[name] = content
				Deferred.resolve()
				return
			, (error) ->
				++reloads
				if reloads <= attempts
					addComponent name, component, true
					console.log "Module \"#{name}\" is unavailable after #{reloads} attempts."
				Deferred.resolve()
				return
			Deferred.promise()

		removeComponent = (name, component) ->
			if name of components
				delete components[name]
				require.undef component
				console.log "Module \"#{name}\" is destroyed."
			return

		getComponent = (name) ->
			components[name]

		contains = (name) ->
			name of components

		{
			name     : "Mediator"
			broadcast: broadcast
			add      : addComponent
			load     : addModule
			remove   : removeComponent
			get      : getComponent
			has      : contains
		}
