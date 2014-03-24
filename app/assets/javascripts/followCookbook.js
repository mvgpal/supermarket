$(function() {
  $("a[rel*='follow']").on('ajax:success', function() {
    $(this).addClass('following');
  });
});
