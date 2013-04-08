module Narrator
  class ControllerResource

    def initialize(controller, *args)
      @controller = controller
      @params = controller.params
      @options = args.extract_options!
      @name = args.first
    end

    def narrate_resource
      # TODO Add skipper for this method
      @controller.narrate(subject, nil, params[:action], current_user)
    end

    protected

    def current_user
      @controller.send(:current_user)
    end

    def resource_class
      case @options[:class]
      when String then @options[:class].constantize
      else @options[:class]
      end
    end

  end
end
