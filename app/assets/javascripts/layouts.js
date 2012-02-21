function hide_flash() {
  $('flash').hide();
  $('not_flash').show();
}

function display_flash(message, notice) {
  if (typeof notice === 'undefined') { notice = true; }  //par défaut notice = true
   
  $('not_flash').hide();
  $('flash').firstChild.style.color = notice ? 'green' : 'red';
  $('flash').firstChild.update(message);
  $('flash').show();
  
  $('flash').addEventListener('mouseover', function(e) {
    e.preventDefault();
    hide_flash();
  }, false);
  
  setTimeout(function() {
    hide_flash();
  }, 5000);  // on efface le flash automatiquement au bout de 5 secondes
};
