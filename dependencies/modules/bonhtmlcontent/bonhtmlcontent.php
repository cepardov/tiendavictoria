<?php
/**
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
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

include_once(_PS_MODULE_DIR_.'bonhtmlcontent/classes/ClassHtmlcontent.php');

class Bonhtmlcontent extends Module
{
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'bonhtmlcontent';
        $this->tab = 'front_office_features';
        $this->version = '1.0.2';
        $this->author = 'Bonpresta';
        $this->module_key = '9ae2e17e4bb93dd10507ed1d016c04c0';
        $this->need_instance = 1;
        $this->bootstrap = true;
        parent::__construct();
        $this->default_language = Language::getLanguage(Configuration::get('PS_LANG_DEFAULT'));
        $this->id_shop = Context::getContext()->shop->id;
        $this->displayName = $this->l('HTML Content');
        $this->description = $this->l('Display html content');
        $this->confirmUninstall = $this->l('This module  Uninstall');
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
        if (Configuration::get('PS_SSL_ENABLED')) {
            $this->ssl = 'https://';
        } else {
            $this->ssl = 'http://';
        }
    }

    public function createAjaxController()
    {
        $tab = new Tab();
        $tab->active = 1;
        $languages = Language::getLanguages(false);
        if (is_array($languages)) {
            foreach ($languages as $language) {
                $tab->name[$language['id_lang']] = 'bonhtmlcontent';
            }
        }
        $tab->class_name = 'AdminAjaxHtmlcontent';
        $tab->module = $this->name;
        $tab->id_parent = - 1;
        return (bool)$tab->add();
    }

    private function removeAjaxContoller()
    {
        if ($tab_id = (int)Tab::getIdFromClassName('AdminAjaxHtmlcontent')) {
            $tab = new Tab($tab_id);
            $tab->delete();
        }

        return true;
    }

    public function install()
    {
        include(dirname(__FILE__).'/sql/install.php');
        $this->installSamples();
        $settings = $this->getModuleSettings();

        foreach ($settings as $name => $value) {
            Configuration::updateValue($name, $value);
        }

        return parent::install() &&
        $this->registerHook('header') &&
        $this->createAjaxController() &&
        $this->registerHook('displayBackOfficeHeader') &&
        $this->registerHook('displayHome');
    }


    protected function installSamples()
    {
        $languages = Language::getLanguages(false);
        for ($i = 1; $i <= 4; ++$i) {
            $item = new ClassHtmlcontent();
            $item->id_shop = (int)$this->context->shop->id;
            $item->status = 1;
            $item->sort_order = $i;
            foreach ($languages as $language) {
                $item->title[$language['id_lang']] = 'html';
                $item->url[$language['id_lang']] = '6-accessories';
                if ($i == 1) {
                    $item->description[$language['id_lang']] = '<div class="box-icon"><i class="fl-puppets-map-point1"></i></div><div class="box-content"><h3>Free Shipping & Return</h3><h5>Free Shipping on all order 
                    over $250</h5></div>';
                } elseif ($i == 2) {
                    $item->description[$language['id_lang']] = '<div class="box-icon"><i class="fl-puppets-bank17"></i></div><div class="box-content"><h3>Money Guarantee</h3><h5>25 days money back 
                    guarantee</h5></div>';
                } elseif ($i == 3) {
                    $item->description[$language['id_lang']] = '<div class="box-icon"><i class="fl-puppets-thumb56"></i></div><div class="box-content"><h3>Payment Secured</h3><h5>All payment secured and trusted</h5></div>';
                } elseif ($i == 4) {
                    $item->description[$language['id_lang']] = '<div class="box-icon"><i class="fl-puppets-telephone114"></i></div><div class="box-content"><h3>Power Support</h3><h5>We support online 
                    24/7 on day</h5></div>';
                }
            }

            $item->add();
        }
    } 

    public function uninstall()
    {
        include(dirname(__FILE__).'/sql/uninstall.php');

        $settings = $this->getModuleSettings();

        foreach (array_keys($settings) as $name) {
            Configuration::deleteByName($name);
        }

        return parent::uninstall()
        && $this->removeAjaxContoller();
    }

    protected function getModuleSettings()
    {
        $settings = array(
            'BON_HTML_LIMIT' => 4,
            'BON_HTML_DISPLAY_CAROUSEL' => false,
            // 'BON_HTML_DISPLAY_ITEM_NB' => 6,
            'BON_HTML_CAROUSEL_NB' => 4,
            'BON_HTML_CAROUSEL_LOOP' => false,
            'BON_HTML_CAROUSEL_NAV' => true,
            'BON_HTML_CAROUSEL_DOTS' => true,
        );
        return $settings;
    }

    public function getContent()
    {

        $output = '';
        $result ='';

        if (((bool)Tools::isSubmit('submitBonhtmlcontentSettingModule')) == true) {
            if (!$errors = $this->validateSettings()) {
                $this->postProcess();
                $output .= $this->displayConfirmation($this->l('Settings updated successful.'));
            } else {
                $output .= $errors;
            }
        }

        if ((bool)Tools::isSubmit('submitUpdateHtmlcontent')) {
            if (!$result = $this->preValidateForm()) {
                $output .= $this->addHtmlcontent();
            } else {
                $output = $result;
                $output .= $this->renderHtmlcontentForm();
            }
        }

        if ((bool)Tools::isSubmit('statusbonHtmlcontent')) {
            $output .= $this->updateStatusTab();
        }

        if ((bool)Tools::isSubmit('deletebonhtmlcontent')) {
            $output .= $this->deleteHtmlcontent();
        }

        if (Tools::getIsset('updatebonhtmlcontent') || Tools::getValue('updatebonhtmlcontent')) {
            $output .= $this->renderHtmlcontentForm();
        } elseif ((bool)Tools::isSubmit('addbonhtmlcontent')) {
            $output .= $this->renderHtmlcontentForm();
        } elseif (!$result) {
            $output .= $this->renderHtmlcontentList();
            $output .= $this->renderFormSettings();
        }

        return $output;
    }

    protected function renderFormSettings()
    {
        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitBonhtmlcontentSettingModule';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false)
            .'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'image_path' => $this->_path.'views/img',
            'fields_value' => $this->getConfigFormValuesSettings(), /* Add values for your inputs */
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
        );

        return $helper->generateForm(array($this->getConfigForm()));
    }


    protected function getConfigForm()
    {
        return array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Settings'),
                    'icon' => 'icon-cogs',
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Display item'),
                        'name' => 'BON_HTML_LIMIT',
                        'col' => 2,
                        'required' => true,
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->l('Carousel:'),
                        'name' => 'BON_HTML_DISPLAY_CAROUSEL',
                        'desc' => $this->l('Display content in the carousel.'),
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled')
                            )
                        ),
                    ),
                    array(
                        'form_group_class' => 'display-block-htmlcontent',
                        'type' => 'text',
                        'label' => $this->l('Items:'),
                        'name' => 'BON_HTML_CAROUSEL_NB',
                        'col' => 2,
                        'desc' => $this->l('The number of items you want to see on the screen.'),
                    ),
                    array(
                        'form_group_class' => 'display-block-htmlcontent',
                        'type' => 'switch',
                        'label' => $this->l('Loop:'),
                        'name' => 'BON_HTML_CAROUSEL_LOOP',
                        'desc' => $this->l('Infinity loop. Duplicate last and first items to get loop illusion.'),
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled')
                            )
                        ),
                    ),
                    array(
                        'form_group_class' => 'display-block-htmlcontent',
                        'type' => 'switch',
                        'label' => $this->l('Nav:'),
                        'name' => 'BON_HTML_CAROUSEL_NAV',
                        'desc' => $this->l('Show next/prev buttons.'),
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled')
                            )
                        ),
                    ),
                    array(
                        'form_group_class' => 'display-block-htmlcontent',
                        'type' => 'switch',
                        'label' => $this->l('Dots:'),
                        'name' => 'BON_HTML_CAROUSEL_DOTS',
                        'desc' => $this->l('Show dots navigation.'),
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => 1,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => 0,
                                'label' => $this->l('Disabled')
                            )
                        ),
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                ),
            ),
        );
    }

    protected function validateSettings()
    {
        $errors = array();

        if (Tools::isEmpty(Tools::getValue('BON_HTML_LIMIT'))) {
            $errors[] = $this->l('Limit is required.');
        } else {
            if (!Validate::isUnsignedInt(Tools::getValue('BON_HTML_LIMIT'))) {
                $errors[] = $this->l('Bad limit format');
            }
        }

        if (Tools::isEmpty(Tools::getValue('BON_HTML_CAROUSEL_NB'))) {
            $errors[] = $this->l('Item is required.');
        } else {
            if (!Validate::isUnsignedInt(Tools::getValue('BON_HTML_CAROUSEL_NB'))) {
                $errors[] = $this->l('Bad item format');
            }
        }

        if ($errors) {
            return $this->displayError(implode('<br />', $errors));
        } else {
            return false;
        }
    }

    protected function getConfigFormValuesSettings()
    {
        $filled_settings = array();
        $settings = $this->getModuleSettings();

        foreach (array_keys($settings) as $name) {
            $filled_settings[$name] = Configuration::get($name);
        }

        return $filled_settings;
    }

    protected function getStringValueType($string)
    {
        if (Validate::isInt($string)) {
            return 'int';
        } elseif (Validate::isFloat($string)) {
            return 'float';
        } elseif (Validate::isBool($string)) {
            return 'bool';
        } else {
            return 'string';
        }
    }

    protected function postProcess()
    {
        $form_values = $this->getConfigFormValuesSettings();

        foreach (array_keys($form_values) as $key) {
            Configuration::updateValue($key, Tools::getValue($key));
        }
    }

    protected function getHtmlcontentSettings()
    {
        $settings = $this->getModuleSettings();
        $get_settings = array();
        foreach (array_keys($settings) as $name) {
            $data = Configuration::get($name);
            $get_settings[$name] = array('value' => $data, 'type' => $this->getStringValueType($data));
        }

        return $get_settings;
    }

    protected function renderHtmlcontentForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => ((int)Tools::getValue('id_tab') ? $this->l('Update html content') : $this->l('Add html content')),
                    'icon' => 'icon-cogs',
                ),
                'input' => array(
                    array(
                        'type' => 'text',
                        'label' => $this->l('Title'),
                        'name' => 'title',
                        'lang' => true,
                        'required' => true,
                        'col' => 3
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Enter URL'),
                        'name' => 'url',
                        'lang' => true,
                        'col' => 3
                    ),
                    array(
                        'type' => 'textarea',
                        'label' => $this->l('Content'),
                        'name' => 'description',
                        'autoload_rte' => true,
                        'lang' => true,
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->l('Status'),
                        'name' => 'status',
                        'is_bool' => true,
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => true,
                                'label' => $this->l('Enabled')
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => false,
                                'label' => $this->l('Disabled')
                            )
                        )
                    ),
                    array(
                        'col' => 2,
                        'type' => 'text',
                        'name' => 'sort_order',
                        'class' => 'hidden'
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                ),
                'buttons' => array(
                    array(
                        'href' => AdminController::$currentIndex.'&configure='.$this->name.'&token='.Tools::getAdminTokenLite('AdminModules'),
                        'title' => $this->l('Back to list'),
                        'icon' => 'process-icon-back'
                    )
                )
            ),
        );

        if ((bool)Tools::getIsset('updatebonhtmlcontent') && (int)Tools::getValue('id_tab') > 0) {
            $tab = new ClassHtmlcontent((int)Tools::getValue('id_tab'));
            $fields_form['form']['input'][] = array('type' => 'hidden', 'name' => 'id_tab', 'value' => (int)$tab->id);
        }

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitUpdateHtmlcontent';
        $helper->currentIndex = AdminController::$currentIndex.'&configure='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigHtmlcontentFormValues(), /* Add values for your inputs */
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
        );

        return $helper->generateForm(array($fields_form));
    }

    protected function getConfigHtmlcontentFormValues()
    {
        if ((bool)Tools::getIsset('updatebonhtmlcontent') && (int)Tools::getValue('id_tab') > 0) {
            $tab = new ClassHtmlcontent((int)Tools::getValue('id_tab'));
        } else {
            $tab = new ClassHtmlcontent();
        }

        $fields_values = array(
            'id_tab' => Tools::getValue('id_tab'),
            'title' => Tools::getValue('title', $tab->title),
            'url' => Tools::getValue('url', $tab->url),
            'status' => Tools::getValue('status', $tab->status),
            'sort_order' => Tools::getValue('sort_order', $tab->sort_order),
        );
        $languages = Language::getLanguages(false);

        foreach ($languages as $lang) {
            $fields_values['description'][$lang['id_lang']] = Tools::getValue(
                'description_' . (int) $lang['id_lang'],
                isset($tab->description[$lang['id_lang']]) ? $tab->description[$lang['id_lang']] : ''
            );
        }
        return $fields_values;
    }

    public function renderHtmlcontentList()
    {
        if (!$tabs = ClassHtmlcontent::getHtmlcontentList()) {
            $tabs = array();
        }

        $fields_list = array(
            'id_tab' => array(
                'title' => $this->l('Id'),
                'type' => 'text',
                'col' => 6,
                'search' => false,
                'orderby' => false,
            ),
            'title' => array(
                'title' => $this->l('Title'),
                'type' => 'text',
                'search' => false,
                'orderby' => false,
            ),
            'status' => array(
                'title' => $this->l('Status'),
                'type' => 'bool',
                'active' => 'status',
                'search' => false,
                'orderby' => false,
            ),
            'sort_order' => array(
                'title' => $this->l('Position'),
                'type' => 'text',
                'search' => false,
                'orderby' => false,
                'class' => 'pointer dragHandle'
            )
        );

        $helper = new HelperList();

        $helper->shopLinkType = '';
        $helper->simple_header = false;
        $helper->identifier = 'id_tab';
        $helper->table = 'bonhtmlcontent';
        $helper->actions = array('edit', 'delete');
        $helper->show_toolbar = true;
        $helper->module = $this;
        $helper->title = $this->displayName;
        $helper->listTotal = count($tabs);
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->toolbar_btn['new'] = array(
            'href' => AdminController::$currentIndex
                .'&configure='.$this->name.'&add'.$this->name
                .'&token='.Tools::getAdminTokenLite('AdminModules'),
            'desc' => $this->l('Add new item')
        );
        $helper->currentIndex = AdminController::$currentIndex
            .'&configure='.$this->name.'&id_shop='.(int)$this->context->shop->id;

        $helper->tpl_vars = array(
            'link' => new Link(),
            'base_dir' => $this->ssl,
            'ps_version' => _PS_VERSION_,
            'lang_iso' => $this->context->language->iso_code,
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
            'image_baseurl' => $this->_path.'images/',
        );

        return $helper->generateList($tabs, $fields_list);
    }

    protected function addHtmlcontent()
    {
        $errors = array();

        if ((int)Tools::getValue('id_tab') > 0) {
            $item = new ClassHtmlcontent((int)Tools::getValue('id_tab'));
        } else {
            $item = new ClassHtmlcontent();
        }

        $item->id_shop = (int)$this->context->shop->id;
        $item->status = (int)Tools::getValue('status');

        if ((int)Tools::getValue('id_tab') > 0) {
            $item->sort_order = Tools::getValue('sort_order');
        } else {
            $item->sort_order = $item->getMaxSortOrder((int)$this->id_shop);
        }

        $languages = Language::getLanguages(false);

        foreach ($languages as $language) {
            $item->title[$language['id_lang']] = Tools::getValue('title_'.$language['id_lang']);
            $item->description[$language['id_lang']] = Tools::getValue('description_'.$language['id_lang']);
            $item->url[$language['id_lang']] = Tools::getValue('url_'.$language['id_lang']);
        }

        if (!$errors) {
            if (!Tools::getValue('id_tab')) {
                if (!$item->add()) {
                    return $this->displayError($this->l('The item could not be added.'));
                }
            } elseif (!$item->update()) {
                return $this->displayError($this->l('The item could not be updated.'));
            }

            return $this->displayConfirmation($this->l('The item is saved.'));
        } else {
            return $this->displayError($this->l('Unknown error occurred.'));
        }
    }

    protected function preValidateForm()
    {
        $errors = array();

        if (Tools::isEmpty(Tools::getValue('title_'.$this->default_language['id_lang']))) {
            $errors[] = $this->l('The title is required.');
        } elseif (!Validate::isGenericName(Tools::getValue('title_'.$this->default_language['id_lang']))) {
            $errors[] = $this->l('Bad title format.');
        }

        if (count($errors)) {
            return $this->displayError(implode('<br />', $errors));
        }
        return false;
    }

    protected function deleteHtmlcontent()
    {
        $tab = new ClassHtmlcontent(Tools::getValue('id_tab'));
        $res = $tab->delete();

        if (!$res) {
            return $this->displayError($this->l('Error occurred when deleting the tab'));
        }

        return $this->displayConfirmation($this->l('The tab is successfully deleted'));
    }

    protected function updateStatusTab()
    {
        $tab = new ClassHtmlcontent(Tools::getValue('id_tab'));

        if ($tab->status == 1) {
            $tab->status = 0;
        } else {
            $tab->status = 1;
        }

        if (!$tab->update()) {
            return $this->displayError($this->l('The tab status could not be updated.'));
        }

        return $this->displayConfirmation($this->l('The tab status is successfully updated.'));
    }

    public function hookDisplayBackOfficeHeader()
    {
        if (Tools::getValue('configure') != $this->name) {
            return;
        }
        Media::addJsDefL('ajax_theme_url', $this->context->link->getAdminLink('AdminAjaxHtmlcontent'));
        $this->context->smarty->assign('ajax_theme_url', $this->context->link->getAdminLink('AdminAjaxHtmlcontent'));
        $this->context->controller->addJquery();
        $this->context->controller->addJqueryUI('ui.sortable');
        $this->context->controller->addJS($this->_path.'views/js/htmlcontent_back.js');
        $this->context->controller->addCSS($this->_path.'views/css/htmlcontent_back.css');
    }

    public function hookHeader()
    {
        $this->context->controller->addJS($this->_path.'/views/js/htmlcontent_front.js');
        $this->context->controller->addCSS($this->_path.'/views/css/htmlcontent_front.css');
        $this->context->controller->addJS($this->_path.'views/js/slick.js');
        $this->context->controller->addCSS($this->_path.'views/css/slick.css', 'all');
        $this->context->controller->addCSS($this->_path.'views/css/slick-theme.css', 'all');

        $this->context->smarty->assign('settings', $this->getHtmlcontentSettings());

        return $this->display($this->_path, '/views/templates/hook/htmlcontent-header.tpl');
    }

    public function hookDisplayHome()
    {
        $htmlcontent_front = new ClassHtmlcontent();
        $tabs = $htmlcontent_front->getTopFrontItems($this->id_shop, true);
        $result = array();

        foreach ($tabs as $key => $tab) {
            $result[$key]['title'] = $tab['title'];
            $result[$key]['description'] = $tab['description'];
            $result[$key]['url'] = $tab['url'];
        }

        $this->context->smarty->assign('items', $result);
        $this->smarty->assign(array(
            'display_carousel' => Configuration::get('BON_HTML_DISPLAY_CAROUSEL'),
        ));
        $this->context->smarty->assign('limit', Configuration::get('BON_HTML_LIMIT'));

        return $this->display(__FILE__, 'views/templates/hook/htmlcontent-front.tpl');
    }

    public function hookdisplayFooterBefore()
    {
        return $this->hookDisplayHome();
    }
}
