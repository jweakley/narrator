module Narrator
  module ControllerAdditions
    module ClassMethods

      def narrate_resource(*args)
        narrator_resource_class.add_after_filter(self, :narrate_resource, *args)
      end

      def narrator_resource_class
        if ancestors.map(&:to_s).include? 'InheritedResources::Actions'
          InheritedResource
        else
          ControllerResource
        end
      end
    end

    def self.included(base)
      base.extend ClassMethods
      base.helper_method :narrate
    end

    def narrate(subject, actor = current_user,  target = nil, verb = params[:action], context = nil)
      if subject.class.respond_to? :track_user_activity
        # Add some config way of determining to use delayed jobs.
        subject.class.track_user_activity(
          (subject.blank? ? nil : subject.id),
          subject.class.to_s,
          (actor.blank? ? nil : actor.id),
          actor.class.to_s,
          (target.blank? ? nil : target.id),
          target.class.to_s,
          verb,
          context
        )
      end
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Narrator::ControllerAdditions
  end
end
