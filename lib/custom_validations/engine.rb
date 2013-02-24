if defined?(Rails)

  module CustomValidations
    module Rails
      class Engine < ::Rails::Engine
        # Rails should look in our vendor directory.
      end
    end
  end

end