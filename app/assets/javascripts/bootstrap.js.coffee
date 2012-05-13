jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("a[rel='tooltip nofollow']").tooltip()  #hack pour pouvoir utiliser un tooltip sur un lien ajax
  $(".alert").alert()
  $("#scroll_to_top").click () => 
    $("body").animate {scrollTop:0}, 'slow'
    false
