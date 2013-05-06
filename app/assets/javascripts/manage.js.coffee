# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

af = -> $('.aftarg').affix(
		offset: 60;
	)

$(document).ready(af)
$(document).on('page:load', af)