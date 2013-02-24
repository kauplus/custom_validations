
/*
# Rails 3 Custom Validations - v0.0.1
# https://github.com/kauplus/custom_validations
#
# Copyright (c) 2013 Kauplus
# Licensed under the MIT license
# http://www.opensource.org/licenses/mit-license.php
*/


(function() {

  jQuery(function() {
    var is_blank, validators;
    is_blank = function(element) {
      return /^\s*$/.test(element.val() || '');
    };
    validators = window.ClientSideValidations.validators;
    return validators.local['email'] = function(element, options) {
      if (is_blank(element)) {
        return;
      }
      if (!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
        return options.message;
      }
    };
  });

}).call(this);
