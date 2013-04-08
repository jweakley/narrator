module Narrator
  module ControllerAdditions
    module ClassMethods

      def narrate_resource(*args)
        narrator_resource_class.add_before_filter(self, :narrate_resource, *args)
      end

      def narrate(subject, verb = params[:action], actor = current_user, target = nil)
        if subject.class.respond_to? :track_user_activity
          # Add some config way of determining to use delayed jobs.
          subject.class.track_user_activity((subject.blank? ? nil : subject.id), (actor.blank? ? nil : actor.id), verb.to_s, target.class.to_s, (target.blank? ? nil : target.id))
        end
      end

      def narrator_resource_class
          ControllerResource
      end

      def self.included(base)
        base.extend ClassMethods
      end

    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Narrator::ControllerAdditions
  end
end
