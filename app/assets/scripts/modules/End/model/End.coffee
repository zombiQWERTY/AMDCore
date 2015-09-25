"use strict"

define ["Facade"], (Facade) ->
	class Model
		validate: (data) ->
			invalidFields = []
			i = 0
			while i < data.length
				if @metadata[data.key].required and !data.value
					invalidFields[invalidFields.length] =
						field: data.key
						message: data.key + ": поле обязательно для заполнения."
				i++
			invalidFields
		metadata:
			"other":
				required: true
	new Model
