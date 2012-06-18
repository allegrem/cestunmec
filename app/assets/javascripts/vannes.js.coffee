# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

this.init_toggle_lol = init_toggle_lol = () ->  #syntaxe un peu lourde mais c'est pour rendre la fonction accessible depuis l'appel ajax
  $('a[class*=bouton-unlol]').bind 'mouseover', (event) -> 
    $(this).html("UN"+$(this).data('content'))
    $(this).removeClass("btn-success disabled")
    $(this).addClass("btn-danger")
    
  $('a[class*=bouton-unlol]').bind 'mouseout', (event) -> 
    $(this).html($(this).data('content'))
    $(this).removeClass("btn-danger")
    $(this).addClass("btn-success disabled")
    
jQuery ->
  init_toggle_lol()
  
  $('.well input').bind 'click', (event) ->
    $(this).parent().parent().submit()