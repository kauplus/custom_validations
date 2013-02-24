###
# Rails 3 Custom Validations - v<%= CustomValidations::VERSION %>
# https://github.com/kauplus/custom_validations
#
# Copyright (c) <%= Time.now.year %> Kauplus
# Licensed under the MIT license
# http://www.opensource.org/licenses/mit-license.php
###

jQuery ->


  is_blank = (element) ->
    /^\s*$/.test(element.val() || '')


  validators = window.ClientSideValidations.validators


  validators.local['email'] = (element, options) ->
    return if is_blank(element) # ignore blank
    unless <%= ActiveModel::Validations::EmailValidator::REGEX.inspect %>.test(element.val())
      options.message

