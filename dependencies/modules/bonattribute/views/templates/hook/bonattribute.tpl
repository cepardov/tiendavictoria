{*
 * 2015-2021 Bonpresta
 *
 * Bonpresta Product Attributes and Combinations
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


{if isset($bon_attr_list_groups)}
    <div id="bonattribute">

        <div class="bonattribute-container">
            {if $type_attr == 'radio_buttons'}

                {foreach from=$bon_attr_list_groups key=id_attribute_group item=group}
                    <div class="bonattribute-box">
                        <button {if $group.texture} style="background-image: url({$group.texture})" {/if}
                            {if $group.group_type == 'color'}style="background: {$group.attribute_color}" {/if}
                            class="bonattribute-btn {$group.group_type}{if $group.quantity =='0'} bon-attribute-disabled{/if}"
                            {if $group.quantity =='0'} disabled {/if} value="{$group.id_product_attribute}" data-quantity="{$group.quantity}">
                            {if $group.group_type == 'radio' || $group.group_type == 'select'} {$group.attribute_name} {/if}
                        </button>
                    </div>
                {/foreach}

            {elseif $type_attr == 'drop_down_list'}

                <div class="bonattribute-box">
                    <select class="bonattribute-btn">
                        {foreach from=$bon_attr_list_groups key=id_attribute_group item=group}
                            <option class=" {if $group.quantity =='0'} bon-attribute-disabled{/if}" {if $group.quantity =='0'}
                            disabled {/if} value="{$group.id_product_attribute}">{$group.attribute_name}</option>
                    {/foreach}
                </select>

            </div>

        {/if}
    </div>
</div>
{/if}


