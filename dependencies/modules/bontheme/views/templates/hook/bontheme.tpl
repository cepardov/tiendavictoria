{*
 * 2015-2020 Bonpresta
 *
 * Bonpresta Theme
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
*}

{if isset($theme_color_demo) && $theme_color_demo}
    <button id="custom-toggler"></button>
{/if}

{if isset($theme_settings) && $theme_settings}
<button id="custom-menu-open"></button>
{/if}

<div class="bon-custom-menu">
    <div class="boxed-setting">
        <p>Boxed:</p>
        <span class="toggle-bg ">
            <input class="input-boxed " type="radio" value="on">
            <span class="switch-boxed "></span>
        </span>
    </div>
    <div class="Sticky-header">
        <p>Sticky Header:</p>
        <span class="toggle-bg active">
            <input class="input-sticky-header" type="radio" value="on">
            <span class="switch-header active"></span>
        </span>
    </div>
    <div class="sticky-addcart">
        <p>Sticky Add To Cart</p>
        <span class="toggle-bg active">
            <input class="input-sticky-cart" type="radio" value="on">
            <span class="switch-cart active"></span>
        </span>
    </div>
    <div class="Sticky-footer">
        <p>Sticky Footer:</p>
        <span class="toggle-bg active">
            <input class="input-sticky-footer" type="radio" value="on">
            <span class="switch-footer active"></span>
        </span>
    </div>
    <div class="bon-select-language">
        <p>Font:</p>
        <form id="bon-select">
            <select class="bon-select-form" name="language-select" form="bon-select">
                <option value="Lato">Lato</option>
                <option value="Raleway">Raleway</option>
                <option value="OpenSans">OpenSans</option>
                <option value="Roboto">Roboto</option>
                <option value="Oswald">Oswald</option>
                <option value="Ubuntu">Ubuntu</option>
                <option value="Playfair">Playfair</option>
                <option value="Lora">Lora</option>
                <option value="Indie">Indie</option>
                <option value="Hind">Hind</option>
            </select>
        </form>
    </div>
</div>

{if isset($theme_promo) && $theme_promo && $theme_enable_promo && ($theme_enable_promo)}
    <div class="promo-container active-list">
        <ul class="promo-list">
            <li class="promo-item active-item">
                <a class="promo-item-inner" target="_blank" href="{$theme_promo_link}">
                    <div class="item-description">
                        <span class="name">Promotion Code -30%</span>
                        <div class="promo-code-value">
                            <span class="value">{$theme_promo}</span>
                        </div>
                        <span class="btn btn-primary">Buy now</span>
                    </div>
                    
                </a>
                <button class="close-promo-popup"></button>
            </li>
        </ul>
    </div> 
{/if}


{if isset($theme_color_enable) && $theme_color_enable}
    <style>
        #bonbanners a .banner-inner span,
        #bonwishlist .wishlist-count,
        #header .blockcart .cart-products-count,
        #bonslick .box-bonslick span,
        li.product-flag.new,
        .meshim_widget_components_chatButton_Button .button_bar,
        body .bon-shipping,
        .btn-primary,
        .featured-products .thumbnail-container .ajax_add_to_cart_button,
        .custom-checkbox input[type=checkbox]+span .checkbox-checked,
        .bonpromotion-countdown-btn,
        .bonsearch .bonsearch_btn,
        .product-accessories .thumbnail-container .ajax_add_to_cart_button,
        .product-miniature .thumbnail-container .ajax_add_to_cart_button,
        .toggle-bg.active {
            background: {$theme_color|escape: 'html':'UTF-8'};
        }
    
        #_desktop_top_menu .top-menu .nav-arrows i,
        #product-availability .product-available,
        .pagination .current a,
        .product-page-right .product-price .current-price,
        #_desktop_top_menu>.top-menu>li.sfHover>a,
        #main .product-information .product-actions #group_1 .input-container label span.check,
        .product-container .product-list .product-item .item-description .product-item-name,
        .product-container .product-list .product-item .item-description .product-item-name:hover,
        #bonwishlist .wishlist_add_to_cart_button:hover i,
        #bonwishlist .wishlist-summary-product-name .product-title:hover span,
        #header .header-top .position-static #_desktop_setting-header i.active {
           color: {$theme_color|escape: 'html':'UTF-8'};
        }
    
        li.product-flag.new:after,
        #productCommentsBlock .pull-right .open-comment-form {
            border-color: {$theme_color|escape: 'html':'UTF-8'};
            border-right-color: transparent;
        }
    
        #_desktop_top_menu ul[data-depth='0']>li>a:after,
        .tabs .nav-tabs .nav-item .nav-link:after,
        .custom-radio input[type='radio']+span:before,
        ::-webkit-scrollbar-thumb:hover,
        .product-actions .add-to-cart:hover,
        .featured-products .thumbnail-container .ajax_add_to_cart_button:hover,
        .product-actions .add-to-cart,
        .product-add-to-cart .product-quantity .bon-stock-countdown .bon-stock-countdown-range .bon-stock-countdown-progress,
        .btn-primary:hover  {
            background: {$theme_color|escape: 'html':'UTF-8'}!important;
        }
    
        .footer-container .links li a:hover:before,
        #bonwishlist .wishlist-tooltip:hover i,
        .products-sort-order .select-title:after,
        #video-container #controls .play:hover:before,
        #video-container #controls .pause:hover:before,
        #video-container #controls .mute:hover:before,
        #video-container #controls .unmute:hover:before,
        #bonslick .slick-prev:hover:before,
        #bonslick .slick-next:hover:before,
        #main .images-container .js-qv-mask .slick-slider .slick-arrow.slick-next:hover:before,
        #main .images-container .js-qv-mask .slick-slider .slick-arrow.slick-prev:hover:before,
        .bonsearch:focus,
        .bonsearch_button.active,
        #header .header-top .position-static #_desktop_setting-header i.active,
        .quickview .modal-content .modal-body .product-price .current-price,
        .comments_note a span:hover,
        .product-quantity .bon-product-popup .title-popup-1:hover,
        .product-quantity .bon-product-popup .title-popup-2:hover,
        .product-add-to-cart .product-quantity .bon-review-inner a:hover,
        .product-quantity .bon-product-popup .title-popup-1:hover:before,
        .product-quantity .bon-product-popup .title-popup-2:hover:before,
        .product-add-to-cart .product-quantity .bon-review-inner a:hover:before{
            color: {$theme_color|escape: 'html':'UTF-8'};
        }
    
        #header .top-menu a[data-depth="0"]:hover,
        #header .header-top .position-static #_desktop_setting-header i:hover,
        .bonsearch:hover,
        .bonsearch_button.active,
        #header .header-top .position-static #_desktop_user_info i:hover,
        #header .header-top .position-static #_desktop_cart .blockcart i:hover,
        #header .header-top .position-static #_desktop_setting-header i.active,
        .bonthumbnails li a:hover,
        .footer-container .links li a:hover,
        #wrapper .breadcrumb li a:hover,
        .pagination a:not(.previous):not(.next):hover,
        .pagination .next:hover,
        .pagination .previous:hover,
        .featured-products .product-title a:hover,
        .product-accessories .product-title a:hover,
        .product-miniature .product-title a:hover,
        .footer-container-bottom a:hover,
        #search_filters .facet .facet-label a:hover,
        #_desktop_top_menu .sub-menu ul[data-depth="1"]>li a:hover,
        #_desktop_top_menu .sub-menu ul[data-depth="2"]>li a:hover,
        .footer-container .product-container .product-list .product-item .item-description .product-item-name:hover,
        #header #_desktop_currency_selector .currency-selector ul li a:hover,
        #back-to-top:hover,
        .bonsearch #search_popup .wrap_item .product_image h5:hover,
        #bon_manufacturers_block .owl-nav .owl-next:hover,
        #bon_manufacturers_block .owl-nav .owl-prev:hover,
        .bon_manufacture_list h4 a:hover,
        .bon-newsletter .bon-newsletter-close>i:hover,
        .product-add-to-cart .product-quantity .bon-product-popup .bon-product-delivery a:hover:before,
        .product-add-to-cart .product-quantity .bon-product-popup .bon-product-delivery a:hover,
        #main .product-information .product-actions #group_1 .input-container label:hover span.radio-label,
        .product-add-to-cart .product-quantity .bon-product-popup .bon-product-size a:hover,
        .product-add-to-cart .product-quantity .bon-product-popup .bon-product-size a:hover:before,
        .product-add-to-cart .product-quantity .bon-product-popup .bon-product-size a:hover,
        .product-add-to-cart .product-quantity .bon-product-popup .bon-product-size a:hover:before,
        #bonwishlist .wishlist-tooltip:hover i {
            color: {$theme_color|escape: 'html':'UTF-8'};
        }
    
        .product-actions .add-to-cart:hover,
        .featured-products .thumbnail-container .ajax_add_to_cart_button:hover,
        #main .product-information .product-actions #group_1 .input-container label span.check,
        #main .product-information .product-actions #group_1 .input-container label:hover span.radio-label {
            border-color: {$theme_color|escape: 'html':'UTF-8'};
            ;
        }
    
        .bonthumbnails li a:hover,
        #main .images-container .js-qv-mask .slick-slider .slick-slide:hover,
        #main .images-container .js-qv-mask .slick-slider .slick-slide.selected,
        body .bonthumbnails li.active,
        body .bonthumbnails li:focus {
            box-shadow: inset 0 0 0 2px {$theme_color|escape: 'html':'UTF-8'};
    </style>
    {/if}