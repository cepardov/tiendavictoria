<?php
/**
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
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class Bonthumbnails extends Module
{
    public function __construct()
    {
        $this->name = 'bonthumbnails';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->bootstrap = true;
        $this->author = 'Bonpresta';
        $this->module_key = '39018a43d3261c725689fc751ad89bbe';
        parent::__construct();
        $this->default_language = Language::getLanguage(Configuration::get('PS_LANG_DEFAULT'));
        $this->id_shop = Context::getContext()->shop->id;
        $this->displayName = $this->l('Gallery Thumbnails On Product List');
        $this->description = $this->l('Display thumbnails gallery on product list.');
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
    }

    protected function getConfigurations()
    {
        $configurations = array(
            'BONTHUMBNAILS_ITEM_STATUS' => true,
            'BONTHUMBNAILS_ITEM_TYPE' => 'vr_hover',
            'BONTHUMBNAILS_ITEM_LIMIT' => 3
        );

        return $configurations;
    }

    public function install()
    {
        $configurations = $this->getConfigurations();

        foreach ($configurations as $name => $config) {
            Configuration::updateValue($name, $config);
        }

        return parent::install() &&
        $this->registerHook('displayHeader') &&
        $this->registerHook('actionProductAdd') &&
        $this->registerHook('actionProductSave') &&
        $this->registerHook('actionProductUpdate') &&
        $this->registerHook('actionProductDelete') &&
        $this->registerHook('displayThumbnailsImage');
    }

    public function uninstall()
    {
        $configurations = $this->getConfigurations();

        foreach (array_keys($configurations) as $config) {
            Configuration::deleteByName($config);
        }

        return parent::uninstall();
    }

    public function getContent()
    {
        $output = '';
        $result = '';

        if ((bool)Tools::isSubmit('submitSettings')) {
            if (!$result = $this->preValidateForm()) {
                $output .= $this->postProcess();
                $output .= $this->displayConfirmation($this->l('Save all settings.'));
            } else {
                $output = $result;
                $output .= $this->renderTabForm();
            }
        }

        if (!$result) {
            $output .= $this->renderTabForm();
        }

        return $output;
    }

    protected function renderTabForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Settings'),
                    'icon' => 'icon-cogs',
                ),
                'input' => array(
                    array(
                        'type' => 'switch',
                        'label' => $this->l('Enable: '),
                        'name' => 'BONTHUMBNAILS_ITEM_STATUS',
                        'is_bool' => true,
                        'values' => array(
                            array(
                                'id' => 'enable',
                                'value' => 1,
                                'label' => $this->l('Yes')),
                            array(
                                'id' => 'disable',
                                'value' => 0,
                                'label' => $this->l('No')),
                        ),
                    ),
                    array(
                        'type' => 'select',
                        'label' => $this->l('Display:'),
                        'name' => 'BONTHUMBNAILS_ITEM_TYPE',
                        'options' => array(
                            'query' => array(
                                array(
                                    'id' => 'vr_hover',
                                    'name' => $this->l('Vertical')),
                                array(
                                    'id' => 'hr_hover',
                                    'name' => $this->l('Horizontal'))

                            ),
                            'id' => 'id',
                            'name' => 'name'
                        )
                    ),
                    array(
                        'type' => 'text',
                        'required' => true,
                        'label' => $this->l('Items:'),
                        'name' => 'BONTHUMBNAILS_ITEM_LIMIT',
                        'col' => 2,
                        'desc' => $this->l('The number of items you want to see on the screen.'),
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                )
            ),
        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->module = $this;
        $helper->default_form_language = $this->context->language->id;
        $helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG', 0);
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitSettings';
        $helper->currentIndex = AdminController::$currentIndex.'&configure='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(), /* Add values for your inputs */
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $this->context->language->id,
        );

        return $helper->generateForm(array($fields_form));
    }

    public function getConfigFieldsValues()
    {
        $fields = array();
        $configurations = $this->getConfigurations();

        foreach (array_keys($configurations) as $config) {
            $fields[$config] = Configuration::get($config);
        }

        return $fields;
    }

    protected function postProcess()
    {
        $form_values = $this->getConfigFieldsValues();

        foreach (array_keys($form_values) as $key) {
            Configuration::updateValue($key, Tools::getValue($key));
        }
    }

    protected function preValidateForm()
    {
        $errors = array();

        if (Tools::isEmpty(Tools::getValue('BONTHUMBNAILS_ITEM_LIMIT'))) {
            $errors[] = $this->l('Item is required.');
        } else {
            if (!Validate::isUnsignedInt(Tools::getValue('BONTHUMBNAILS_ITEM_LIMIT'))) {
                $errors[] = $this->l('Bad item format');
            }
        }

        if (count($errors)) {
            return $this->displayError(implode('<br />', $errors));
        }

        return false;
    }

    protected function getSmartyConfigurations()
    {
        return array(
            'status' => Configuration::get('BONTHUMBNAILS_ITEM_STATUS'),
        );
    }

    protected function getStringValueType($data)
    {
        if (Validate::isInt($data)) {
            return 'int';
        } elseif (Validate::isFloat($data)) {
            return 'float';
        } elseif (Validate::isBool($data)) {
            return 'bool';
        } else {
            return 'string';
        }
    }

    protected function getThumbnailsSettings()
    {
        $settings = $this->getConfigurations();
        $get_settings = array();

        foreach (array_keys($settings) as $name) {
            $data = Configuration::get($name);
            $get_settings[$name] = array('value' => $data, 'type' => $this->getStringValueType($data));
        }

        return $get_settings;
    }

    public function hookActionProductAdd()
    {
        $this->clearCache();
    }

    public function hookActionProductSave()
    {
        $this->clearCache();
    }

    public function hookActionProductUpdate()
    {
        $this->clearCache();
    }

    public function hookActionProductDelete()
    {
        $this->clearCache();
    }

    protected function clearCache()
    {
        $this->_clearCache('homefeatured.tpl');
        $this->_clearCache('blocknewproducts_home.tpl');
        $this->_clearCache('blockspecials-home.tpl');
        $this->_clearCache('blockbestsellers-home.tpl');
        $this->_clearCache('bonthumbnails_image.tpl');
    }

    public function getCacheId($id_product = null)
    {
        return parent::getCacheId().'|'.(int)$id_product;
    }

    public function hookDisplayHeader()
    {
        $this->context->controller->addJS($this->_path . '/views/js/bonthumbnails_image.js');
        $this->context->controller->addCSS($this->_path . '/views/css/bonthumbnails_image.css');
    }

    public function hookDisplayThumbnailsImage($params)
    {
        if (Configuration::get('BONTHUMBNAILS_ITEM_STATUS')) {
            $id_product = (int)$params['product']['id_product'];

            if (!$this->isCached('bonthumbnails_image.tpl', $this->getCacheId($id_product))) {
                $product = new Product($id_product);
                $this->smarty->assign(array(
                    'images' => $product->getImages($this->context->language->id),
                    'product' => $params['product'],
                    'configurations' => $this->getSmartyConfigurations(),
                    'link' => new Link(),
                    'bonthumbnails_style' => Configuration::get('BONTHUMBNAILS_ITEM_TYPE'),
                    'bonthumbnails_limit' => Configuration::get('BONTHUMBNAILS_ITEM_LIMIT'),
                ));
            }

            return $this->display($this->_path, '/views/templates/hook/bonthumbnails_image.tpl', $this->getCacheId($id_product));
        }
    }
}
