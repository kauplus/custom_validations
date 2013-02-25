
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
    var is_blank, validates_cnpj, validates_cpf, validators;
    is_blank = function(element) {
      return /^\s*$/.test(element.val() || '');
    };
    validates_cpf = function(cpf) {
      var i, result, sum;
      cpf = $.trim(cpf).replace(/\.|\-/g, '').split('');
      sum = 0;
      i = 10;
      $.each(cpf.slice(0, 9), function() {
        sum += parseInt(this) * i;
        return i -= 1;
      });
      result = sum % 11;
      if (result < 2) {
        result = 0;
      } else {
        result = 11 - result;
      }
      if (result !== parseInt(cpf[9])) {
        return false;
      }
      sum = 0;
      i = 11;
      $.each(cpf.slice(0, 10), function() {
        sum += parseInt(this) * i;
        return i -= 1;
      });
      result = sum % 11;
      if (result < 2) {
        result = 0;
      } else {
        result = 11 - result;
      }
      return result === parseInt(cpf[10]);
    };
    validates_cnpj = function(cnpj) {
      var sum;
      cnpj = $.trim(cnpj).replace(/[^0-9]/g, '').split('');
      sum = 5 * parseInt(cnpj[0]) + 4 * parseInt(cnpj[1]) + 3 * parseInt(cnpj[2]) + 2 * parseInt(cnpj[3]);
      sum += 9 * parseInt(cnpj[4]) + 8 * parseInt(cnpj[5]) + 7 * parseInt(cnpj[6]) + 6 * parseInt(cnpj[7]);
      sum += 5 * parseInt(cnpj[8]) + 4 * parseInt(cnpj[9]) + 3 * parseInt(cnpj[10]) + 2 * parseInt(cnpj[11]);
      sum = 11 - parseInt(sum % 11);
      if (sum >= 10) {
        sum = 0;
      }
      if (sum !== parseInt(cnpj[12])) {
        return false;
      }
      sum = 6 * parseInt(cnpj[0]) + 5 * parseInt(cnpj[1]) + 4 * parseInt(cnpj[2]) + 3 * parseInt(cnpj[3]);
      sum += 2 * parseInt(cnpj[4]) + 9 * parseInt(cnpj[5]) + 8 * parseInt(cnpj[6]) + 7 * parseInt(cnpj[7]);
      sum += 6 * parseInt(cnpj[8]) + 5 * parseInt(cnpj[9]) + 4 * parseInt(cnpj[10]) + 3 * parseInt(cnpj[11]);
      sum += 2 * parseInt(cnpj[12]);
      sum = 11 - parseInt(sum % 11);
      if (sum >= 10) {
        sum = 0;
      }
      return sum === parseInt(cnpj[13]);
    };
    validators = window.ClientSideValidations.validators;
    validators.local['br_cpf'] = function(element, options) {
      if (is_blank(element)) {
        return;
      }
      if (!validates_cpf(element.val())) {
        return options.message;
      }
    };
    validators.local['br_cnpj'] = function(element, options) {
      if (is_blank(element)) {
        return;
      }
      if (!validates_cnpj(element.val())) {
        return options.message;
      }
    };
    validators.local['br_postal_code'] = function(element, options) {
      if (is_blank(element)) {
        return;
      }
      if (!/^\d{5}\-?\d{3}$/.test(element.val())) {
        return options.message;
      }
    };
    validators.local['email'] = function(element, options) {
      if (is_blank(element)) {
        return;
      }
      if (!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
        return options.message;
      }
    };
    return validators.remote['url'] = function(element, options) {
      var response;
      if (is_blank(element)) {
        return;
      }
      response = $.ajax({
        dataType: 'json',
        url: '/validators/url',
        data: {
          value: element.val(),
          as_host: options.as_host
        },
        async: false
      });
      if (response.status === 400) {
        return JSON.parse(response.responseText)['message'];
      }
    };
  });

}).call(this);
