$(function() {
  $("a[rel*='follow']").on('ajax:success', function() {
    $.get('', function(data) {
      $('.follow').replaceWith($(data).find('.follow'));
    });
  });
});
