{*
* 2015-2021 Bonpresta
*
* Bonpresta Product Compare
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

<div class="modal fade" id="compare-wrapper" tabindex="-1" role="dialog" aria-labelledby="#compare-wrapper"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <h2 class="title">{l s='Product Comparison' mod='boncompare'}</h2>
            <button type="button" class="popup-close" data-dismiss="modal" aria-label="Close"></button>
            <div class="modal-body">
                {if isset($products) && $products}
                    <div class="boncompare-list">
                        <div class="div-table">
                            <div class="div-table-row">
                                <div class="div-table-col boncompare-features">
                                </div>
                                {foreach from=$products item=product name=product}
                                    <div class="div-table-col main-info"
                                        data-id-compare="{$product.info.id_product|escape:'htmlall':'UTF-8'}">
                                        <a class="thumbnail product-thumbnail"
                                            href="{$product.info.url|escape:'htmlall':'UTF-8'}">
                                            <img class="replace-2x img-responsive"
                                                src="{$product.info.cover.bySize.home_default.url|escape:'htmlall':'UTF-8'}"
                                                alt="{$product.info.cover.legend|escape:'htmlall':'UTF-8'}"
                                                data-full-size-image-url="{$product.info.cover.large.url|escape:'htmlall':'UTF-8'}">
                                            <h6 class="h3 product-title" itemprop="name">
                                                {$product.info.name|escape:'htmlall':'UTF-8'}
                                            </h6>
                                            {hook h="displayProductListReviews" product=$product.info}
                                            <div class="product-info">
                                                {block name='product_price_and_shipping'}
                                                    {if $product.info.show_price}
                                                        <div class="compare-summary-product-price">
                                                            <span
                                                                class="price {if $product.info.has_discount}has-discount{/if}">{$product.info.price|escape:'htmlall':'UTF-8'}</span>
                                                            {if $product.info.has_discount}
                                                                <span
                                                                    class="regular-price">{$product.info.regular_price|escape:'htmlall':'UTF-8'}</span>
                                                            {/if}
                                                        </div>
                                                    {/if}
                                                {/block}
                                                <div class="compare_add_to_cart">
                                                    {* <div class="bonwishlist-hook-wrapper"
                                                        data-id-product="{$product.info.id_product|escape:'htmlall':'UTF-8'}">
                                                        {hook h="displayBonWishlist"}
                                                    </div> *}
                                                    <form action="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}"
                                                        method="post" class="add-to-cart-or-refresh">
                                                        <input type="hidden" name="token"
                                                            value="{$static_token|escape:'htmlall':'UTF-8'}">
                                                        <input type="hidden" name="id_product"
                                                            value="{$product.info.id_product|escape:'htmlall':'UTF-8'}"
                                                            class="product_page_product_id">
                                                        <input type="hidden" name="qty" value="1">
                                                        <button class="compare_add_to_cart_button"
                                                            data-button-action="add-to-cart" type="submit"
                                                            onclick="closeBoncompare()">
                                                            <i class="fl-outicons-shopping-cart13"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            <span class="compare-button-delete"></span>
                                            {block name='product_flags'}
                                                <ul class="product-flags">
                                                    {foreach from=$product.info.flags item=flag}
                                                        <li class="product-flag {$flag.type}">{$flag.label|escape:'htmlall':'UTF-8'}
                                                            {if $flag.type === 'on-sale'}
                                                                {if $product.info.discount_type === 'percentage'}
                                                                    <span
                                                                        class="discount-percentage discount-product">{$product.info.discount_percentage|escape:'htmlall':'UTF-8'}</span>
                                                                {elseif $product.info.discount_type === 'amount'}
                                                                    <span
                                                                        class="discount-amount discount-product">{$product.info.discount_amount_to_display|escape:'htmlall':'UTF-8'}</span>
                                                                {/if}
                                                            {/if}
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            {/block}
                                        </a>
                                    </div>
                                {/foreach}
                            </div>
                            <div class="div-table-row">
                                <div class="div-table-col boncompare-features">
                                    <h5>{l s='Category' mod='boncompare'}</h5>
                                </div>
                                {foreach from=$products item=product name=product}
                                    <div class="div-table-col"
                                        data-id-compare="{$product.info.id_product|escape:'htmlall':'UTF-8'}">
                                        <p>{if !$product.category}-{else}{$product.category|escape:'htmlall':'UTF-8'}{/if}
                                        </p>
                                    </div>
                                {/foreach}
                            </div>
                            <div class="div-table-row">
                                <div class="div-table-col boncompare-features">
                                    <h5>{l s='Manufacture' mod='boncompare'}</h5>
                                </div>
                                {foreach from=$products item=product name=product}
                                    <div class="div-table-col"
                                        data-id-compare="{$product.info.id_product|escape:'htmlall':'UTF-8'}">
                                        <p>{if
                                                !$product.manufacturer_name}-{else}{$product.manufacturer_name|escape:'htmlall':'UTF-8'}
                                        {/if}
                                    </p>
                                </div>
                            {/foreach}
                        </div>
                        <div class="div-table-row">
                            <div class="div-table-col boncompare-features">
                                <h5>{l s='Attributes' mod='boncompare'}</h5>
                            </div>
                            {foreach from=$products item=product name=product}
                                <div class="div-table-col compare-attr"
                                    data-id-compare="{$product.info.id_product|escape:'htmlall':'UTF-8'}">
                                    {if !$product.attributes}
                                        <p>-</p>
                                    {else}
                                        {foreach from=$product.attributes item=attribute name=attribute}
                                            <span>{$attribute|escape:'htmlall':'UTF-8'}</span><span>,</span>
                                        {/foreach}
                                    {/if}
                                </div>
                            {/foreach}
                        </div>
                        <div class="div-table-row">
                            <div class="div-table-col boncompare-features">
                                <h5>{l s='Features' mod='boncompare'}</h5>
                            </div>
                            {foreach from=$products item=product name=product}
                                <div class="div-table-col"
                                    data-id-compare="{$product.info.id_product|escape:'htmlall':'UTF-8'}">
                                    {if !$product.info.features}
                                        <p>-</p>
                                    {else}
                                        {foreach from=$product.info.features item=feature name=feature}
                                            <p><span>{$feature.name|escape:'htmlall':'UTF-8'}</span> -
                                                <span>{$feature.value|escape:'htmlall':'UTF-8'}</span>
                                            </p>
                                        {/foreach}
                                    {/if}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
                {else}
                <div class="no-compare">
                    <img src="{_MODULE_DIR_}boncompare/views/img/compare.png" alt="compare">
                    <h6>{l s='There are no more items in your compare' mod='boncompare'}
                    </h6>
                </div>
                {/if}
                <div class="no-compare-js no-compare" style="display: none;">
                    <img src="{_MODULE_DIR_}boncompare/views/img/compare.png" alt="compare">
                    <h6>{l s='There are no more items in your compare' mod='boncompare'}
                </div>
            </div>
        </div>
    </div>
</div>