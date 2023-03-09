{*
* 2015-2021 Bonpresta
*
* Bonpresta Wishlist
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
* @author Bonpresta
* @copyright 2015-2021 Bonpresta
* @license http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div class="wishlist-wrapper">
    {if isset($products) && $products}
        <div class="wishlist-list">
            {foreach from=$products item=product name=product}
                <article class="wishlist-item" data-id-product="{$product.info.id_product|escape:'htmlall':'UTF-8'}"
                    data-id-product-attribute="{$product.info.id_product_attribute|escape:'htmlall':'UTF-8'}">
                    <div class="wishlist-summary-product-image">
                        <a class="thumbnail product-thumbnail" href="{$product.info.url|escape:'htmlall':'UTF-8'}">
                            <img class="replace-2x img-responsive"
                                src="{$product.info.cover.bySize.home_default.url|escape:'htmlall':'UTF-8'}"
                                alt="{$product.info.cover.legend|escape:'htmlall':'UTF-8'}"
                                data-full-size-image-url="{$product.info.cover.large.url|escape:'htmlall':'UTF-8'}">
                        </a>
                    </div>
                    <div class="wishlist-summary-product-info">
                        <div class="wishlist-summary-product-name">
                            {block name='product_name'}
                                <h1 class="h3 product-title" itemprop="name"><a
                                        href="{$product.info.url|escape:'htmlall':'UTF-8'}"><span>{$product.info.name|escape:'htmlall':'UTF-8'}</span></a>
                                </h1>
                            {/block}
                        </div>
                        {block name='product_price_and_shipping'}
                            {if $product.info.show_price}
                                <div class="wishlist-summary-product-price">
                                    <span
                                        class="price {if $product.info.has_discount}has-discount{/if}">{$product.info.price|escape:'htmlall':'UTF-8'}</span>
                                    {if $product.info.has_discount}
                                        {hook h='displayProductPriceBlock' product=$product.info type="old_price"}
                                        <span class="regular-price">{$product.info.regular_price|escape:'htmlall':'UTF-8'}</span>
                                    {/if}
                                </div>
                            {/if}
                        {/block}
                        <form action="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}" method="post"
                            class="add-to-cart-or-refresh">
                            <input type="hidden" name="token" value="{$static_token|escape:'htmlall':'UTF-8'}">
                            <input type="hidden" name="id_product" value="{$product.info.id_product|escape:'htmlall':'UTF-8'}"
                                class="product_page_product_id">
                            <input type="hidden" name="qty" value="1">
                            <button class="wishlist_add_to_cart_button" data-button-action="add-to-cart" type="submit">
                                <i class="fl-line-icon-set-shopping63"></i>
                            </button>
                        </form>
                    </div>
                    <div class="wishlist-button-delete"></div>
                </article>
            {/foreach}
        </div>
    {else}
        <div class="no-items">
        <h6>{l s='There are no more items in your wishlist' mod='bonwishlist'}
        </h6>
        </div>
    {/if}
    <div class="no-items-js no-items" style="display: none;">
        <h6>{l s='There are no more items in your wishlist' mod='bonwishlist'}
        </h6>
    </div>
</div>