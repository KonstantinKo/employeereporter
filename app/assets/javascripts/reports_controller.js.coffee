# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#new_report').on "keyup keypress", (e) ->
    code = e.keyCode || e.which
    if code is 13 #Enter
      e.preventDefault()
      false

  $('#new_report').on 'keydown', '.multi_answer', (e) ->
    code = e.keyCode || e.which
    if code is 13 #Enter
      add_new_input_under e.currentTarget
      e.preventDefault()

add_new_input_under = (field) ->
  jField = $(field)
  name = jField.attr('name')
  new_field = '<br><input class="string required multi_answer" name="'+name+'" type="text" autofocus="true">'
  $(jField).after new_field