module ActiveModel
  module Validations


    class BrPostalCodeValidator < ActiveModel::EachValidator

      REGEX = /^\d{5}\-?\d{3}$/

      def validate_each(record, attribute, value)
        return if value.to_s.blank? # it doesn't validate presence
        unless value.to_s =~ REGEX
          record.errors.add(attribute, :br_postal_code, options)
        end
      end
    end


    module HelperMethods
      def validates_br_postal_code_of(*attr_names)
        validates_with BrPostalCodeValidator, _merge_attributes(attr_names)
      end
    end

  end
end
