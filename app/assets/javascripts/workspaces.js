$(document).on('keyup click', 'input#search', function() {
  key_search = $(this).val();
  if (key_search.length > 0) {
    $.get($('#search_position').attr('action'), $('#search_position').serialize(),
      null, 'script');
    return false;
  } else {
    $('.list-group').slideUp();
  }
});

$(document).on('click', '.search-position', function(e) {
  row = $(this).data('row');
  column = $(this).data('column');
  $('.td_position_' + row + '_' + column).css('background', 'red');
  $('.list-group').hide();
});
