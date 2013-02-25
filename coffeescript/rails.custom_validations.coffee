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


  validates_cpf = (cpf) ->
    cpf = $.trim(cpf).replace(/\.|\-/g,'').split('')

    # calculate first digit
    sum = 0
    i = 10
    $.each(cpf.slice(0,9), ->
      sum += parseInt(this)*i
      i -= 1
    )

    result = sum % 11
    if result < 2
      result = 0
    else
      result = 11 - result

    if result != parseInt(cpf[9])
      return false


    # calculate second digit
    sum = 0
    i = 11
    $.each(cpf.slice(0,10), ->
      sum += parseInt(this)*i
      i -= 1
    )

    result = sum % 11
    if result < 2
      result = 0
    else
      result = 11 - result

    result == parseInt(cpf[10])


  validates_cnpj = (cnpj) ->
    cnpj = $.trim(cnpj).replace(/[^0-9]/g,'').split('')

    # calculate first digit
    sum  = 5 * parseInt(cnpj[0]) + 4 * parseInt(cnpj[1]) + 3 * parseInt(cnpj[2]) + 2 * parseInt(cnpj[3])
    sum += 9 * parseInt(cnpj[4]) + 8 * parseInt(cnpj[5]) + 7 * parseInt(cnpj[6]) + 6 * parseInt(cnpj[7])
    sum += 5 * parseInt(cnpj[8]) + 4 * parseInt(cnpj[9]) + 3 * parseInt(cnpj[10]) + 2 * parseInt(cnpj[11])
    sum  = 11 - parseInt(sum % 11)

    if sum >= 10
      sum = 0

    if sum != parseInt(cnpj[12])
      return false

    sum = 6 * parseInt(cnpj[0]) + 5 * parseInt(cnpj[1]) + 4 * parseInt(cnpj[2]) + 3 * parseInt(cnpj[3])
    sum += 2 * parseInt(cnpj[4]) + 9 * parseInt(cnpj[5]) + 8 * parseInt(cnpj[6]) + 7 * parseInt(cnpj[7])
    sum += 6 * parseInt(cnpj[8]) + 5 * parseInt(cnpj[9]) + 4 * parseInt(cnpj[10]) + 3 * parseInt(cnpj[11])
    sum += 2 * parseInt(cnpj[12])
    sum = 11 - parseInt( sum % 11 )

    if sum >= 10
      sum = 0

    sum == parseInt(cnpj[13])


  validators = window.ClientSideValidations.validators


  #
  # Local validators
  #
  validators.local['br_cpf'] = (element, options) ->
    return if is_blank(element) # ignore blank
    if !validates_cpf(element.val())
      options.message

  validators.local['br_cnpj'] = (element, options) ->
    return if is_blank(element) # ignore blank
    if !validates_cnpj(element.val())
      options.message

  validators.local['br_postal_code'] = (element, options) ->
    return if is_blank(element) # ignore blank
    unless <%= ActiveModel::Validations::BrPostalCodeValidator::REGEX.inspect %>.test(element.val())
      options.message

  validators.local['email'] = (element, options) ->
    return if is_blank(element) # ignore blank
    unless <%= ActiveModel::Validations::EmailValidator::REGEX.inspect %>.test(element.val())
      options.message


  #
  # Remote validators
  #
  validators.remote['url'] = (element, options) ->
    return if is_blank(element) # ignore blank

    response = $.ajax
      dataType: 'json'
      url: '/validators/url'
      data:
        value: element.val()
        as_host: options.as_host
      async: false # MUST be false

    JSON.parse(response.responseText)['message'] if response.status == 400

