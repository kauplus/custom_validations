# CustomValidations

CustomValidatons is a Rails 3 gem that provides a series of custom validations. The following validations are available:

* validates_email_of
* validates_url_of
* validates_br_cnpj_of
* validates_br_cpf_of
* validates_br_postal_code_of

## Installation

Add this line to your application's Gemfile:

    gem 'custom_validations'

And then execute:

    bundle

Or install it yourself as:

    gem install custom_validations


## Usage

You can use CustomValidations in any class that includes ActiveModel::Validations. See an example below on how to use it with an ActiveRecord class:

    class DummyClass < ActiveRecord::Base

      validates :contact_email, email: true
      #validates_email_of :contact_email # use it the way you want

      validates :cpf,       br_cpf: true
      validates :cnpj,      br_cnpj: true
      validates :cep,       br_postal_code: true
      validates :url,       url: true
      validates :hostname,  url: { as_host: true }

    end


## I18n

You can customize the error messages for each validation. See https://github.com/kauplus/custom_validations/blob/master/lib/custom_validations/locale/en.yml.

Example:

    "pt-BR":
      errors:
        messages:
          br_cpf: "não é um CPF válido"
          br_cnpj: "não é um CNPJ válido"
          br_postal_code: "não é um CEP válido"
          email: "não é um endereço de email"
          url: "é uma url inválida"
          url_as_host: "é uma url inválida (informe apenas o domínio, sem http e /)"


## Use along with ClientSideValidations

All the custom validations are automatically available via javascript for you when using https://github.com/bcardarella/client_side_validations.

In your app/assets/javascripts/application.js:

    //= require rails.validations
    //= require rails.custom_validations


## Contributing

1. Fork it
2. Create your validation branch (`git checkout -b my-new-validation`)
3. Commit your changes (`git commit -am 'Added validation'`)
4. Push to the branch (`git push origin my-new-validation`)
5. Create new Pull Request
