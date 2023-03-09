/*
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

window.addEventListener("DOMContentLoaded", () => {
  bonAttribute();
  prestashop.on("updateProductList", () => {
    bonAttribute();
  });
});

function bonAttribute() {
  $(".bonattribute-btn").change(function () {
    if ($(this).val() == 0) return false;
    // $(".bon_id_attr").attr("value", $(this).val());
    $(this).parents('.add-to-cart-or-refresh').children('.bon_id_attr').attr("value", $(this).val());
  });

  $(".bonattribute-btn").each(function () {
    $(this).click(function (e) {
      e.preventDefault();
      $("#bonattribute .bonattribute-btn").removeClass("active");
      $(this).addClass("active");
      let dataIdAttr = $(this).attr("value");
      let dataQuantity = $(this).attr("data-quantity");
      $(this).parents('.add-to-cart-or-refresh').children('.bon_id_attr').attr("value", dataIdAttr);
      if (dataQuantity == 0) {
          $('.ajax_add_to_cart_button').prop( "disabled", true );
      } else{
        $('.ajax_add_to_cart_button').prop( "disabled", false );
      }
    });
  });
}




