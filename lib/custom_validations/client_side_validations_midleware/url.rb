module ClientSideValidations::Middleware
  class Url < Base

    class URLValidationClass
      include ActiveModel::Validations
      attr_accessor :url
      validates_url_of :url
    end

    class URLAsHostValidationClass
      include ActiveModel::Validations
      attr_accessor :url
      validates_url_of :url, as_host: true
    end

    def response

      if request.params[:as_host] == 'true'
        obj = URLAsHostValidationClass.new
      else
        obj = URLValidationClass.new
      end

      obj.url = request.params[:value]
      obj.valid?

      if obj.errors.has_key? :url
        self.status = 400
        self.body = {message: obj.errors[:url].first}.to_json
      else
        self.status = 200
        self.body = 'true'
      end

      super
    end
  end
end