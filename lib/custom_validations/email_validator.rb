module ActiveModel
  module Validations


    class EmailValidator < ActiveModel::EachValidator

      REGEX = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

      def validate_each(record, attribute, value)
        return if value.to_s.blank? # it doesn't validate presence
        unless value.to_s =~ REGEX
          record.errors.add(attribute, :email, options)
        end
      end
    end


    module HelperMethods
      def validates_email_of(*attr_names)
        validates_with EmailValidator, _merge_attributes(attr_names)
      end
    end

  end
end

#
# REGEX taken from:
# http://guides.rubyonrails.org/v3.1.3/active_record_validations_callbacks.html#custom-validators
#