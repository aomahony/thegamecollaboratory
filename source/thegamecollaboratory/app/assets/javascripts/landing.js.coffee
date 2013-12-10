# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
   $(document).on(
      "ajax:beforeSend": (event, xhr, settings) ->
         #Before Send
      "ajax:success": (event, data, status, xhr) ->
         $('.success').html(data.message).show()
         $('.error').hide()
      "ajax:error": (event, xhr, status, error) ->
         data = jQuery.parseJSON(xhr.responseText)
         $('.success').hide()
         $('.error').html(data.message).show()
   )