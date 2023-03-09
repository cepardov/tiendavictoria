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

<div id="_desktop_search_widget" class="bonsearch"
    data-search-controller-url={$link->getPageLink('search')|escape:'html':'UTF-8'}">
    <span class="bonsearch_button current">
        <i class="fl-outicons-magnifying-glass34"></i>
    </span>

    <div class="bonsearch_box bon_drop_down">
        <form method="get" action="{$link->getPageLink('search')|escape:'html':'UTF-8'}" id="searchbox">
            <div class="search-form-inner">
                <input type="hidden" name="controller" value="search" />
                <input type="text" id="input_search" name="search_query" placeholder="{l s='Search' mod='bonsearch'}"
                    class="ui-autocomplete-input" autocomplete="off" />
                <button class="bonsearch-microphone" id="bonsearch-microphone" data-toggle="modal"
                    data-target="#bonsearch-popup-wrapper">
                    <i class="fl-outicons-microphone10"></i>
                </button>
                <button class="bonsearch_btn" type="submit"></button>
            </div>
            <div id="search_popup"></div>
        </form>
    </div>
</div>

<div class="modal fade" data-backdrop="false" id="bonsearch-popup-wrapper">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <button type="button" class="popup-close" data-dismiss="modal" aria-label="Close"></button>
            <div class="modal-body">
                <div class="bonsearch-icon-speech">
                    <i class="fl-outicons-microphone10"></i>
                </div>
                <div class="bonsearch-speek-text">
                    <p>{l s='Say something...' mod='bonsearch'}</p>
                </div>
                <div class="bonsearch-error-text">
                    <p>{l s='Nothing found. Please repeat.' mod='bonsearch'}</p>
                </div>
                <div class="bonsearch-unsupport-text">
                    <p>{l s='Unsupported browser. Sorry...' mod='bonsearch'}</p>
                </div>
            </div>
        </div>
    </div>
</div>