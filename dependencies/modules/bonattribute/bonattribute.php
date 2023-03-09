<?php
/**
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
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class Bonattribute extends Module
{
    protected $templatePath;
    public function __construct()
    {
        $this->name = 'bonattribute';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->bootstrap = true;
        $this->author = 'Bonpresta';
        $this->module_key = '501dfbfe7bed75b0385446410aff54db';
        parent::__construct();
        $this->default_language = Language::getLanguage(Configuration::get('PS_LANG_DEFAULT'));
        $this->id_shop = Context::getContext()->shop->id;
        $this->displayName = $this->l('Product Attributes and Combinations');
        $this->description = $this->l('Display attribute and combinations in product list.');
        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);
        $this->templatePath = 'module:'.$this->name.'/views/templates/hook/';
    }

    protected function getConfigurations()
    {
        $configurations = array(
            'BON_ATTRIBUTE_ENABLE' => true,
            'BON_TYPE_ATTR' => 'radio_buttons'
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
        $this->registerHook('displayBonAttribute') &&
        $this->registerHook('displayAttributeButton') &&
        $this->registerHook('displayHeader');
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
                        'label' => $this->l('Enable:'),
                        'name' => 'BON_ATTRIBUTE_ENABLE',
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
                        'form_group_class' => 'bon_modules_attr_type',
                        'label' => $this->l('Attribute type'),
                        'name' => 'BON_TYPE_ATTR',
                        'options' => array(
                            'query' => array(
                                array(
                                    'id' => 'drop_down_list',
                                    'name' => $this->l('Drop-down list')
                                ),
                                array(
                                    'id' => 'radio_buttons',
                                    'name' => $this->l('Radio buttons')
                                ),
                                
                            ),
                            'name' => 'name',
                            'id' => 'id',
                            'index' => 'BON_TYPE_ATTR'
                        ),
                        'col' => 2,
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
            'fields_value' => $this->getConfigFieldsValues(),
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

        if (count($errors)) {
            return $this->displayError(implode('<br />', $errors));
        }

        return false;
    }

    public function hookDisplayHeader()
    {
        if (Configuration::get('BON_ATTRIBUTE_ENABLE')) {
            $this->context->controller->addJS($this->_path . '/views/js/bonattribute.js');
            $this->context->controller->addCSS($this->_path . '/views/css/bonattribute.css');
        }
    }

    public function hookDisplayProductListReviews($params)
    {
        $product = new Product($params['product']['id_product'], false);
        $attributes_groups = $product->getAttributesGroups($this->context->language->id);
        $mainArr = array();
        $result = array();
        
        if (is_array($attributes_groups) && $attributes_groups) {
            foreach ($attributes_groups as $key => $row) {
                       $mainArr[$key]['id_product_attribute'] = $row['id_product_attribute'];
                       $mainArr[$key]['attribute_name'] = $row['attribute_name'];
                       $mainArr[$key]['group_name'] = $row['group_name'];
                       $mainArr[$key]['public_group_name'] = $row['public_group_name'];
                       $mainArr[$key]['price'] = $row['price'];
                       $mainArr[$key]['group_type'] = $row['group_type'];
                       $mainArr[$key]['attribute_color'] = $row['attribute_color'];
                       $mainArr[$key]['quantity'] = $row['quantity'];
                       $mainArr[$key]['texture'] = (@filemtime(_PS_COL_IMG_DIR_ . $row['id_attribute'] . '.jpg')) ? _THEME_COL_DIR_ . $row['id_attribute'] . '.jpg' : '';
            }

            foreach ($mainArr as $item) {
                $id = $item['id_product_attribute'];
                if (!isset($result[$id])) {
                    $result[$id] = $item;
                } else {
                    $result[$id]['attribute_name'] .= ', '.$item['attribute_name'];
                }
            }
            
            Media::addJsDefL('bon_type_attr', Configuration::get('BON_TYPE_ATTR'));

            $this->context->smarty->assign(array(
               'bon_attr_list_groups' => $result,
               'type_attr' => Configuration::get('BON_TYPE_ATTR'),
            ));
            return $this->fetch($this->templatePath.'bonattribute.tpl');
        }
        return false;
    }


    public function hookDisplayAttributeButton($params)
    {
        $product = new Product($params['product']['id_product'], false);
        $attributes_groups = $product->getAttributesGroups($this->context->language->id);
        $mainArr = array();
        if (is_array($attributes_groups) && $attributes_groups) {
            return $this->fetch($this->templatePath.'bonattribute-button.tpl');
        }
        return false;
    }

    public function hookdisplayBonAttribute($params)
    {
        return $this->hookDisplayProductListReviews($params);
    }
}
