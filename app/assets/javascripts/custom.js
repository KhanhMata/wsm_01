$(document).ready(function() {
  var toggle = true;
    $('.sidebar-icon').click(function() {
      if (toggle)
      {
        $('.page-container').addClass('sidebar-collapsed').removeClass('sidebar-collapsed-back');
        $('#menu span').css({'position': 'absolute'});
      }
      else
      {
        $('.page-container').removeClass('sidebar-collapsed').addClass('sidebar-collapsed-back');
        setTimeout(function() {
        $('#menu span').css({'position': 'relative'});
      }, 400);
    }
  toggle = !toggle;
  });

  $('.datepicker').datetimepicker({
    useCurrent: false,
    format: 'YYYY/MM/DD HH:mm'
  });
});
$(function ($) {
    "use strict";
    function doAnimations(elems) {
      //Cache the animationend event in a variable
      var animEndEv = 'webkitAnimationEnd animationend';
      elems.each(function () {
        var $this = $(this),
          $animationType = $this.data('animation');
        $this.addClass($animationType).one(animEndEv, function () {
          $this.removeClass($animationType);
        });
      });
    }
    //Variables on page load
    var $immortalCarousel = $('.animate_text'),
      $firstAnimatingElems = $immortalCarousel.find('.item:first').
        find("[data-animation ^= 'animated']");
    //Initialize carousel
    $immortalCarousel.carousel();
    //Animate captions in first slide on page load
    doAnimations($firstAnimatingElems);
    //Other slides to be animated on carousel slide event
    $immortalCarousel.on('slide.bs.carousel', function (e) {
      var $animatingElems = $(e.relatedTarget).
        find("[data-animation ^= 'animated']");
      doAnimations($animatingElems);
    });
})(jQuery);
