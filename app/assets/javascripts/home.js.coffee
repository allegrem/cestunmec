# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready () ->
#   $('.hero-unit').css('background-image', 'url("assets/background.png")')
#     .css('background-position', '0px 0px')
  img = new Image()
  img.onload = () -> 
    $(".hero-unit").addClass("home-background")
      .css('background-position', '0px 0px')
  img.src = 'assets/background.png'