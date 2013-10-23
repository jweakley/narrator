module Narrator
  class ControllerResource

    def self.add_after_filter(controller_class, method, *args)
      options = args.extract_options!
      resource_name = args.first
      after_filter_method = options.delete(:prepend) ? :prepend_after_filter : :after_filter
      controller_class.send(after_filter_method, options.slice(:only, :except, :if, :unless)) do |controller|
        controller.class.narrator_resource_class.new(controller, resource_name, options.except(:only, :except, :if, :unless)).send(method)
      end
    end

    def initialize(controller, *args)
      @controller = controller
      @params = controller.params
      @options = args.extract_options!
      @name = args.first
    end

    def narrate_resource
      @controller.narrate(resource_instance) if resource_instance.valid?
    end

    protected

    def current_user
      @controller.send(:current_user)
    end

    def resource_instance
      @controller.instance_variable_get("@#{instance_name}")
    end

    def name
      @name || name_from_controller
    end

    def name_from_controller
      @params[:controller].sub('Controller', '').underscore.split('/').last.singularize
    end

    def instance_name
      @options[:instance_name] || name
    end
  end
end
