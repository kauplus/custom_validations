module ActiveModel
  module Validations


    class UrlValidator < ActiveModel::EachValidator

      def initialize(options)
        options[:as_host] = false if options[:as_host].blank?
        super
      end

      def validate_each(record, attribute, value)
        return if value.to_s.blank? # it doesn't validate presence

        valid = begin
          uri = URI.parse(value)
          uri.kind_of?(URI::HTTP) and !uri.host.to_s.match /^\./
        rescue URI::InvalidURIError
          false
        end


        if options[:as_host] and uri.kind_of?(URI::Generic)
          if uri.scheme.present? or value.match(/\?|\/|\:|^\s*\./)
            record.errors.add(attribute, :url_as_host, options)
          end

        elsif !valid
          record.errors.add(attribute, :url, options)
        end

      end
    end


    module HelperMethods
      def validates_url_of(*attr_names)
        validates_with UrlValidator, _merge_attributes(attr_names)
      end
    end

  end
end

#
# URL validation is very difficult to perform. There are several points of view
# on what is a valid URL and what URLs should be considered in validations.
# We will do a pragmatic validation here. If the URL is parsable, then it's valid.
# See the tests to learn what we have considered as valid and invalid urls.
# Nice discussion here:
# http://stackoverflow.com/questions/7167895/whats-a-good-way-to-validate-links-urls-in-rails-3
#