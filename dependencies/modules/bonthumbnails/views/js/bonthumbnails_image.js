/**
 * 2015-2019 Bonpresta
 *
 * Bonpresta Gallery Thumbnails On Product List
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
 *  @copyright 2015-2019 Bonpresta
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*/

(function($){
    'use strict';

        $('.bonthumbnails li:first-child').addClass('active');
        $(document).on('click', '.bonthumbnails li a', function(e) {
            e.preventDefault();
            var urlThumbnails = $(this).attr('data-href');
            var boxThumbnails = $(this).parent().parent().prev('.product-thumbnail').find('img');
            $(boxThumbnails).attr('src', urlThumbnails);
            $(this).parent().parent().find('li.active').removeClass('active');
            $(this).parent().addClass('active');
        });

}(jQuery));
