jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $("a[rel='tooltip nofollow']").tooltip()  #hack pour pouvoir utiliser un tooltip sur un lien ajax
  
  #fonction alert perso (remplace celle de bootstrap)
  $('.alert .close').bind 'click', (e) =>
    $(e.currentTarget).parent().parent().slideUp 'fast'
    false
  
  #scroll to top basique
  $("#scroll_to_top").click () => 
    $("body").animate {scrollTop:0}, 'slow'
    false
