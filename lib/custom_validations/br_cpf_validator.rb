module ActiveModel
  module Validations


    class BrCpfValidator < ActiveModel::EachValidator
      BLACK_LIST = %w(12345678909 11111111111 22222222222 33333333333 44444444444
                      55555555555 66666666666 77777777777 88888888888 99999999999
                      00000000000)

      def validate_each(record, attribute, value)
        return if value.to_s.blank? # it doesn't validate presence
        record.errors.add(attribute, :br_cpf, options) unless valid_cpf?(value.to_s)
      end

      def valid_cpf? cpf
        begin
          cpf = (cpf.is_a?(String) ? cpf : cpf.to_s)
        rescue
          return false
        end

        # could be 10 or 11 digits or with mask 999.999.999-99
        if cpf !~ /^\d{10,11}$|\d{3}\.\d{3}\.\d{3}-\d{2}$/
          return false
        end

        cpf = cpf.scan(/\d/).collect(&:to_i)
        cpf.unshift(0) if cpf.length == 10

        # filter black list
        if BLACK_LIST.include? cpf.join
          return false
        end

        # calculate first digit
        sum = (0..8).inject(0) do |sum, i|
          sum + cpf[i] * (10 - i)
        end

        result = sum % 11
        result = result < 2 ? 0 : 11 - result

        if result != cpf[9]
          return false
        end

        # calculate second digit
        sum = (0..8).inject(0) do |sum, i|
          sum + cpf[i] * (11 - i)
        end

        sum += cpf[9] * 2

        result = sum % 11
        result = result < 2 ? 0 : 11 - result

        result == cpf[10]
      end
    end


    module HelperMethods
      def validates_br_cpf_of(*attr_names)
        validates_with BrCpfValidator, _merge_attributes(attr_names)
      end
    end

  end
end
