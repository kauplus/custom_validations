# Require dependencies used by many classes of this Gem
require 'active_model'

# Require base code
require 'custom_validations/version'
require 'custom_validations/engine'
require 'custom_validations/email_validator'

# Load translations
require 'active_support/i18n'
I18n.load_path << File.dirname(__FILE__) + '/custom_validations/locale/en.yml'