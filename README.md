# CustomValidations

CustomValidatons is a Rails 3 gem that provides a series of custom validations. The following validations are available:

* validates_email_of


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

      validates_email_of :contact_email
      #validates :contact_email, email: true # use it the way you want

    end


## I18n

You can customize the error messages for each validation. See https://github.com/kauplus/custom_validations/blob/master/lib/custom_validations/locale/en.yml.

Example:

    "pt-BR":
      errors:
        messages:
          email: "não é um endereço de email"


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
