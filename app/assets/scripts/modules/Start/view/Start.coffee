"use strict"

define ["jquery", "Facade", "text!templates/Start/Start.html"], ($, Facade, Template) ->
	class View
		constructor: (data) ->
			html = Template.replace "{{ text }}", data
			$("body").html html
