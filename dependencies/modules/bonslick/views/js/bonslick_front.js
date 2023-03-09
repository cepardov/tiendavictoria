/**
 * 2015-2020 Bonpresta
 *
 * Bonpresta Awesome Image Slider
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the General Public License (GPL 2.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/GPL-2.0
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade the module to newer
 * versions in the future.
 *
 *  @author    Bonpresta
 *  @copyright 2015-2020 Bonpresta
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*/

$(document).ready(function(){
if(BON_SLICK_CAROUSEL_DOTS == 1) {
    var BON_SLICK_CAROUSEL_DOTS_SCRIPT = true;
} else {
    var BON_SLICK_CAROUSEL_DOTS_SCRIPT = false;
}
if(BON_SLICK_CAROUSEL_NAV == 1) {
    var BON_SLICK_CAROUSEL_NAV_SCRIPT = true;
} else {
    var BON_SLICK_CAROUSEL_NAV_SCRIPT = false;
}
if(BON_SLICK_CAROUSEL_AUTOPLAY == 1) {
    var BON_SLICK_CAROUSEL_AUTOPLAY_SCRIPT = true;
} else {
    var BON_SLICK_CAROUSEL_AUTOPLAY_SCRIPT = false;
}
if(BON_SLICK_CAROUSEL_LOOP == 1) {
    var BON_SLICK_CAROUSEL_LOOP_SCRIPT = true;
} else {
    var BON_SLICK_CAROUSEL_LOOP_SCRIPT = false;
}
if(BON_SLICK_CAROUSEL_DRAG == 1) {
    var BON_SLICK_CAROUSEL_DRAG_SCRIPT = true;
} else {
    var BON_SLICK_CAROUSEL_DRAG_SCRIPT = false;
}

$('.bonslick-slider').slick({
        infinite: BON_SLICK_CAROUSEL_LOOP_SCRIPT,
        autoplaySpeed: BON_SLICK_CAROUSEL_TIME,
        draggable: BON_SLICK_CAROUSEL_DRAG_SCRIPT,
        dots: BON_SLICK_CAROUSEL_DOTS_SCRIPT,
        arrows: BON_SLICK_CAROUSEL_NAV_SCRIPT,
        autoplay: BON_SLICK_CAROUSEL_AUTOPLAY_SCRIPT,
        slidesToShow: 1,
        slidesToScroll: 1,
        fade: true,
        lazyLoad: 'progressive',
});
    removeVideoMobile() 
    var player = document.getElementById('video-element');

    if(player != null) {
        sliderChange();
    }
    $(window).resize(function () {
        removeVideoMobile();
      });

});



function sliderChange()
{
    $('.bonslick-slider').on('afterChange', function (event, slick, currentSlide) {
        btnMute.removeAttribute('title');
        btnPlayPause.removeAttribute('title');
        if (currentSlide == $('#bonslick .slick-slide').length - 1) {
            if ($('#btnPlayPause').hasClass('play') || $('#btnPlayPause').hasClass('pause')) {
                $('#btnPlayPause').trigger('click').attr('class', 'pause').addClass('active-sound');
            } else {
                $('.pause').trigger('click');
            }
            $('.slick-prev').addClass('white-arrow');
            $('.slick-next').addClass('white-arrow');
        } else {
            $('.pause').trigger('click');
            $('.slick-prev').removeClass('white-arrow');
            $('.slick-next').removeClass('white-arrow');
        }
    });

}

function removeVideoMobile() {
    if ($(window).width() <= '575'){
        for (let i = 0; i < $('#bonslick .slick-slide').length; i++) {
            let videoMobile = $('#video-container').parent();
            let index = videoMobile.attr('data-slick-index');
        $('.bonslick-slider').slick('slickRemove', index);
        }
    }
}