{*
 * 2015-2021 Bonpresta
 *
 * Bonpresta Advanced Ajax Live Search Product
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
 *  @copyright 2015-2021 Bonpresta
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div class="wrap_item">
    {if isset($products) && $products}
        {foreach from=$products item=product name=product}
            <a href="{$product.link|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" class="product_image">
                {if isset($enable_image) && $enable_image}
                    <div class="search_img">
                        <img src="{$link->getImageLink($product.id_image, $product.id_image, 'home_default')|escape:'html':'UTF-8'}"
                            title="{$product.name|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" />
                    </div>
                {/if}
                <div class="search_info">
                    {if isset($enable_name) && $enable_name}
                        <h5>
                            {$product.name|truncate:35:'...'|escape:'html':'UTF-8'}
                        </h5>
                    {/if}
                    {if isset($enable_reference) && $enable_reference}
                        <span class="reference">{l s='Reference:' mod='bonsearch'} {$product.reference|escape:'html':'UTF-8'}</span>
                    {/if}
                    {if isset($enable_price) && $enable_price}
                        <span class="price">{$product.price|escape:'html':'UTF-8'|string_format:"%.2f"}
                            {$currensy|escape:'html':'UTF-8'}</span>
                    {/if}
                </div>
            </a>
        {/foreach}
    {else}
        <h6>{$search_alert|escape:'html':'UTF-8'}</h6>
    {/if}
</div>