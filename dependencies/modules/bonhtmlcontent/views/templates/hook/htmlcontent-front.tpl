{*
 * 2015-2020 Bonpresta
 *
 * Bonpresta HTML Content
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

{if isset($items) && $items}
  <section id="bonhtmlcontent">
    <div class="container">
        <ul class="{if !$display_carousel}row {else}slick-carousel-htmlcontent {/if} revealOnScroll animated fadeInUp"  data-animation="fadeInUp">
            {foreach from=$items item=item name=item}
                {if $smarty.foreach.item.iteration <= $limit}
                    <li {if !$display_carousel}class="col-sm-6 col-md-6 col-lg-3"{/if}>
                        {if isset($item.url) && $item.url}
                            <a class="link-htmlcontent" href="{$item.url|escape:'htmlall':'UTF-8'}">
                        {/if}
                            {if isset($item.description) && $item.description}
                                <div class="box-htmlcontent">
                                    {$item.description nofilter}
                                </div>
                            {/if}
                        {if isset($item.url) && $item.url}
                            </a>
                        {/if}
                    </li>
                {/if}
            {/foreach}
        </ul>
    </div>
 </section>
{/if}
