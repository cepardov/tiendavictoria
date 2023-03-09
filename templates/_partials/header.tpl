{block name='header_banner'}
    <div class="header-banner">
        {hook h='displayBanner'}
    </div>
{/block}

{block name='header_nav'}
    <nav class="header-nav">
        <div class="container">
            <div class="row">
                <div class="" id="_mobile_logo">
                    <a href="{$urls.base_url}">
                        {$shop.name}
                    </a>
                </div>
                <div class="hidden-sm-down">
                    <div class="col-md-5 col-xs-12">
                        {hook h='displayNav1'}
                    </div>
                    <div class="col-md-7 right-nav">
                        {hook h='displayNav2'}
                    </div>
                </div>
                <div class="hidden-md-up text-sm-center mobile">
                    <div class="float-xs-left" id="menu-icon">
                        <i class="fl-outicons-lines7"></i>
                    </div>
                    {* <div class="float-xs-left bonsearch" id="_mobile_search_widget"></div> *}
                    <div class="float-xs-right" id="_mobile_setting-header"></div>
                    {* <div class="float-xs-right" id="_mobile_cart"></div>
                    <div class="float-xs-right" id="_mobile_user_info"></div>
                    <div class="float-xs-right" id="_mobile_bonwishlist"></div>
                    <div class="top-logo" id="_mobile_logo"></div> *}
                </div>
            </div>
        </div>
    </nav>
{/block}

{block name='header_top'}
    <div class="header-top revealOnScroll animated fadeInUp" data-animation="fadeInUp">
        <div class="container">
            <div class="row">
                <div class="col-md-12 position-static">
                    <div class="hidden-sm-down" id="_desktop_logo">
                        <a href="{$urls.base_url}">
                            {$shop.name}
                        </a>
                    </div>
                    {hook h='displayTop'}
                    <div id="_desktop_setting-header">
                        <i class="current fl-outicons-gear40"></i>
                        <div class="setting-header-inner"></div>
                    </div>


                    <div class="clearfix"></div>
                </div>
            </div>
            <div id="mobile_top_menu_wrapper" class="row hidden-md-up" style="display:none;">
                <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
                <div class="js-top-menu-bottom">
                    <div id="_mobile_currency_selector"></div>
                    <div id="_mobile_language_selector"></div>
                    <div id="_mobile_contact_link"></div>
                </div>
            </div>
        </div>
    </div>
    {hook h='displayNavFullWidth'}
{/block}

