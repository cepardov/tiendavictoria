{*
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
*}

{if isset($configurations.status) && $configurations.status}
    {if count($images) > 1}
        <ul class="bonthumbnails bon_{$bonthumbnails_style|escape:'html':'UTF-8'}">
            {foreach from=$images item=image name=image}
                {assign var=imageId value="`$product.id_product`-`$image.id_image`"}
                {if $smarty.foreach.image.iteration <= $bonthumbnails_limit}
                    <li>
                        <a href="{if Configuration::get('PS_SSL_ENABLED')}https://{else}http://{/if}{$link->getImageLink($product.link_rewrite, $imageId, 'home_default')|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" data-href="{if Configuration::get('PS_SSL_ENABLED')}https://{else}http://{/if}{$link->getImageLink($product.link_rewrite, $imageId, 'home_default')|escape:'html':'UTF-8'}">
                            <img class="img-fluid" src="{if Configuration::get('PS_SSL_ENABLED')}https://{else}http://{/if}{$link->getImageLink($product.link_rewrite, $imageId, 'home_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}" />
                        </a>
                    </li>
                {/if}
            {/foreach}
        </ul>
    {/if}
{/if}



