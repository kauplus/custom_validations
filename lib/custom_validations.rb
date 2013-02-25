# Require dependencies used by many classes of this Gem
require 'active_model'

# Require base code
require 'custom_validations/version'
require 'custom_validations/engine'

# Require validators
require 'custom_validations/br_postal_code_validator'
require 'custom_validations/br_cpf_validator'
require 'custom_validations/br_cnpj_validator'
require 'custom_validations/email_validator'
require 'custom_validations/url_validator'

# Require ClientSideValidations midlewares
if defined?(ClientSideValidations)
  require 'custom_validations/client_side_validations_midleware/url'
end

# Load translations
require 'active_support/i18n'
I18n.load_path << File.dirname(__FILE__) + '/custom_validations/locale/en.yml'