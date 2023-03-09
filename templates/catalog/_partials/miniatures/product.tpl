{*
 * 2007-2019 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{block name='product_miniature_item'}
    <article data-animation="fadeInUp"
        class=" {if $page.page_name == 'category'} classForgrid {/if}revealOnScroll animated fadeInUp product-miniature js-product-miniature {if $page.page_name == 'index'}col-xs-12 col-sm-6  col-lg-3{elseif $page.page_name == 'category'}col-xs-12 col-sm-6 col-md-6 col-lg-4{else}col-xs-12 col-md-4 col-lg-3{/if}    {if isset($layout)}{if $layout == 'layouts/layout-full-width.tpl'}col-xs-12 col-sm-6 col-md-3{/if}{/if}"
        data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope
        itemtype="http://schema.org/Product">
        <meta itemprop="sku" content="{$product.id_product}" />
        <meta itemprop="mpn" content="{$product.reference}" />
        <div class="thumbnail-container">
            <div class="thumbnail-container-inner">
                <div class="thumbnail-container-images">
                    {block name='product_thumbnail'}
                        {if $product.cover}
                            <a href="{$product.url}" class="thumbnail product-thumbnail">
                                <img src="{$product.cover.bySize.home_default.url}"
                                    alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                                    data-full-size-image-url="{$product.cover.large.url}" itemprop="image">
                                {block name='quick_view'}
                                    <button class="quick-view" href="#" data-link-action="quickview">
                                        {l s='Quick view' d='Shop.Theme.Actions'}
                                    </button>
                                {/block}
                                <div class="bonwishlist-hook-wrapper" data-id-product="{$product.id}">
                                    {hook h="displayBonWishlist"}
                                </div>
                                <div class="boncompare-hook-wrapper" data-id-compare="{$product.id}">
                                    {hook h="displayBonCompare"}
                                </div>
                            </a>

                            {hook h="displayThumbnailsImage" product=$product type="hover"}
                        {else}
                            <a href="{$product.url}" class="thumbnail product-thumbnail">
                                <img src="{$urls.no_picture_image.bySize.home_default.url}">
                            </a>
                        {/if}
                    {/block}
                    {hook h='displayProductPriceBlock' product=$product type="before_price"}

                    {block name='product_flags'}
                        <ul class="product-flags">
                            {foreach from=$product.flags item=flag}


                                <li class="product-flag {$flag.type}">{$flag.label}
                                    {if $flag.type === 'on-sale'}
                                        {if $product.discount_type === 'percentage'}
                                            <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
                                        {elseif $product.discount_type === 'amount'}
                                            <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                                        {/if}
                                    {/if}



                                </li>
                            {/foreach}
                        </ul>
                    {/block}
                </div>
                <div class="thumbnail-container-bottom">
                    <div class="product-description">

                        {hook h='displayProductPriceBlock' product=$product type='weight'}

                        {block name='product_reviews'}
                            {hook h='displayProductListReviews' product=$product}
                        {/block}
                        <div style="display: none" itemprop="review" itemscope itemtype="https://schema.org/Review">
                            <p itemprop="author">author</p>
                        </div>
                        {block name='product_name'}

                            {if $page.page_name == 'index'}
                                <h3 class="h3 product-title" itemprop="name"><a
                                        href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
                            {else}
                                <h3 class="h3 product-title" itemprop="name"><a
                                        href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
                            {/if}
                        {/block}

                        {block name='product_description_short'}
                            <div class="sort-description" id="product-description-short-{$product.id}" itemprop="description">
                                <p>
                                    {$product.description_short|strip_tags:'UTF-8'|truncate:130:'...'}
                                </p>
                            </div>

                        {/block}

                        {block name='product_price_and_shipping'}
                            {if $product.show_price}
                                <div class="product-price-and-shipping" itemprop="offers" itemscope
                                    itemtype="http://schema.org/Offer">
                                    <span itemprop="price" content="{$product.price_amount}"
                                        class="price {if $product.has_discount}price-has-discount{/if}">{$product.price}</span>
                                    <link itemprop="availability" href="{$product.seo_availability}" />
                                    <meta itemprop="priceValidUntil" content="2029-12-31" />
                                    <link itemprop="url" href="{$product.link}" />
                                    <meta itemprop="priceCurrency" content="{$currency.iso_code}" />
                                    {if $product.has_discount}
                                        {hook h='displayProductPriceBlock' product=$product type="old_price"}

                                        <span class="sr-only">{l s='Regular price' d='Shop.Theme.Catalog'}</span>
                                        <span class="regular-price">{$product.regular_price}</span>


                                    {/if}

                                    <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>

                                    {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                                </div>
                            {/if}
                        {/block}
                    </div>

                    {* {block name='product_variants'}

                        {if $product.main_variants}
                        <div class="highlighted-informations
                            {if !$product.main_variants} no-variants
                            {/if} hidden-sm-down">

                            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                        </div>

                        {/if}

                    {/block} *}

                    <form action="{$urls.pages.cart}" method="post" class="add-to-cart-or-refresh">
                        <input type="hidden" name="token" value="{$static_token}">
                        <input type="hidden" name="id_product" value="{$product.id}" class="product_page_product_id">
                        <input type="hidden" name="qty" value="1">
                        {hook h='displayAttributeButton' product=$product}
                        {hook h='displayBonAttribute' product=$product}
                        <div class="btn-row">
                            <button class="ajax_add_to_cart_button btn btn-primary add-to-cart"
                                data-button-action="add-to-cart" type="submit" {if $product.quantity < 1 }disabled{/if}>
                                <i class="fl-outicons-shopping-cart13"></i>
                                {l s='Add to cart' d='Shop.Theme.Actions'}
                            </button>

                            <a href="{$product.url}" class="btn-view btn btn-primary">
                                {l s='view product' d='Shop.Theme.Actions'}
                            </a>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </article>
{/block}