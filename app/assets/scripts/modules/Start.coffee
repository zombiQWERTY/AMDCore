"use strict"

define ["Facade"], (Facade) ->
	Facade.Modules.Add "TestObject", do ->
		someNumber = 0
		someString = "another sample variable"
		{
			onInitialize: ->
				alert "Module TestObject is initialized."
				return
			onFakeEvent: ->
				someNumber++
				alert "Handled " + someNumber + " times!"
				return
			onSetString: (str) ->
				someString = str
				alert "Assigned " + someString
				return

		}

	# Facade.Modules.Broadcast "TestObject", "Initialize", [], ->

	# 	return
	# alerts "TestObject initialized"
	# Facade.Modules.Broadcast "FakeEvent"
	# # alerts "Handled 1 times!" (I know, bad grammar)
	# Facade.Modules.Broadcast "SetString", [ "test string" ]
	# # alerts "Assigned test string"
	# Facade.Modules.Broadcast "FakeEvent"
	# # alerts "Handled 2 times!"
	# Facade.Modules.Broadcast "SessionStart"
	# # this call is safely ignored
	# Facade.Modules.Broadcast "Translate", [ "this is also safely ignored" ]

	return
