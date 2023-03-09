{*
* 2015-2021 Bonpresta
*
* Bonpresta Collection Manager with Photos and Videos
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

{if isset($items) && $items}
    <div class="container">
        <div class="clearfix"></div>
        <section id="boncollection" class="boncollection-home">
            <div class="title-block revealOnScroll animated fadeInUp" data-animation="fadeInUp">
                <a href="{$link->getModuleLink('boncollection', 'main')|escape:'htmlall':'UTF-8'}">
                    <h2 class="h2 products-section-title text-uppercase">
                        {l s='Our Collections' mod='boncollection'}
                    </h2>
                </a>
                <span>{l s='Stay ahead of the trends with our collections.' mod='boncollection'}</span>
            </div>
            <ul class="boncollection-slider home revealOnScroll animated fadeInUp" data-animation="fadeInUp">
                {foreach from=$items item=item name=item}
                    {assign var="collection_url" value="{$link->getModuleLink('boncollection', 'collection', ['id_tab'=>$item.id, 'link_rewrite'=>$item.url])|escape:'htmlall':'UTF-8'}"}
                    {if $smarty.foreach.item.iteration <= $limit}
                        <li class="boncollection-item col-12 col-xs-12 col-md-6 col-lg-4 revealOnScroll animated fadeInUp"
                            data-animation="fadeInUp">
                            {if isset($item.image) && $item.image}
                                <a class="boncollection-image" href="{$collection_url|escape:'htmlall':'UTF-8'}">
                                    <img class="img-responsive"
                                        src="{$image_baseurl|escape:'htmlall':'UTF-8'}{$item.image|escape:'htmlall':'UTF-8'}"
                                        alt="{$item.title|escape:'htmlall':'UTF-8'}" />
                                    <div class="boncollection-item-title">
                                        {if isset($item.title) && $item.title}
                                            <h3>{$item.title|escape:'htmlall':'UTF-8'}</h3>
                                            <i class="fl-outicons-right-arrow30"></i>
                                        {/if}
                                    </div>
                                </a>
                            {/if}
                        </li>
                    {/if}
                {/foreach}
            </ul>
            {* <a class="boncollection-show-all revealOnScroll animated fadeInUp" data-animation="fadeInUp"
                href="{$link->getModuleLink('boncollection', 'main')|escape:'htmlall':'UTF-8'}">{l s='Show All Collections' mod='collection'}</a> *}
        </section>
    </div>
{/if}