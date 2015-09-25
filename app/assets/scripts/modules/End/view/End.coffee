"use strict"

define ["jquery", "Facade", "text!templates/End/End.html"], ($, Facade, Template) ->
	class View
		constructor: (data) ->
			html = Template.replace "{{ text }}", data
			$("body").html html
