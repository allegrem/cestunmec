# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready () ->
  #on differe le chargement de l'image de fond
  if $("#main-hero-unit").length > 0
    img = new Image()
    img.onload = () -> 
      $("#main-hero-unit").addClass("home-background")
      .css('background-position', '0px 0px')
    img.src = 'assets/background.png'