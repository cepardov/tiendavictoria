/**
 * 2015-2022 Bonpresta
 *
 * Bonpresta Instagram Gallery Feed Photos & Videos User
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
 *  @copyright 2015-2022 Bonpresta
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */
function heightSlide() {
    let slideHeight = $('#boninstagram .instagram-item').width();

    $('#boninstagram .instagram-item').css('height', slideHeight + 'px');
}
$(document).ready(function () {
    if (BONINSTAGRAM_DOTS == 1) {
        var BONINSTAGRAM_DOTS_SCRIPT = true;
    } else {
        var BONINSTAGRAM_DOTS_SCRIPT = false;
    }
    if (BONINSTAGRAM_NAV == 1) {
        var BONINSTAGRAM_NAV_SCRIPT = true;
    } else {
        var BONINSTAGRAM_NAV_SCRIPT = false;
    }
    if (BONINSTAGRAM_LOOP == 1) {
        var BONINSTAGRAM_LOOP_SCRIPT = true;
    } else {
        var BONINSTAGRAM_LOOP_SCRIPT = false;
    }
    if (BONINSTAGRAM_MARGIN) {
        $('#boninstagram ul li a').css('margin', '0 ' + BONINSTAGRAM_MARGIN / 2 + 'px');
    }
    $('.slick-carousel-instagram').bonslick({
        slidesToShow: BONINSTAGRAM_NB,
        infinite: BONINSTAGRAM_LOOP_SCRIPT,
        autoplaySpeed: BONINSTAGRAM_SPEED,
        draggable: true,
        transformEnabled: false,
        dots: BONINSTAGRAM_DOTS_SCRIPT,
        arrows: BONINSTAGRAM_NAV_SCRIPT,
        autoplay: true,
        slidesToScroll: 1,
        responsive: [{
            breakpoint: 1200,
            settings: {
                slidesToShow: 4,
            }

        }, {
            breakpoint: 800,
            settings: {
                slidesToShow: 3,
            }


        }, {
            breakpoint: 600,
            settings: {
                slidesToShow: 2,
            }
        }, {
            breakpoint: 480,
            settings: {
                slidesToShow: 1,
            }
        }]
    });
    setTimeout(() => {
        heightSlide();
    }, 400);
    window.addEventListener('resize', function(event) {
        heightSlide();
    });
});