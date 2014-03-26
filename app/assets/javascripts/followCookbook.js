$(function() {
  /*
   * Gets the markup for the follow button from the current page
   * and dynamically swaps it out then rebinds the ajax:success event.
   */
  var updateButtonState = function() {
    $.get('', function(data) {
      $('.follow').replaceWith($(data).find('.follow'));
      $('.follow').on('ajax:success', updateButtonState);
    });
  }

  /*
   * Bind the successful ajax request attached to follow/unfollow buttons
   * to updateButtonState function.
   */
  $('.follow').on('ajax:success', updateButtonState);
});
