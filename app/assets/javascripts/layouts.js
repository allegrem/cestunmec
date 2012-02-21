function display_flash(message, notice) {
  if (typeof notice === 'undefined') { notice = true; }  //par défaut notice = true
   
  $('not_flash').hide();
  $('flash').firstChild.style.color = notice ? 'green' : 'red';
  $('flash').firstChild.update(message);
  $('flash').show();
  
  $('flash').addEventListener('mouseout', function(e) {
    e.preventDefault();
    $('flash').hide();
    $('not_flash').show();
  }, false);
};