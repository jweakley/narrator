module Narrator
  module ControllerAdditions
    module ClassMethods

      def narrate_resource(*args)
        narrator_resource_class.add_before_filter(self, :narrate_resource, *args)
      end

      def narrate(subject, target = nil, verb = params[:action], actor_id = current_user.user_profile_id)
        if user_signed_in?
          subject.class.delay.track_user_activity(subject.id, actor_id, target.class.to_s, (target.blank? ? nil : target.id), verb.to_s)
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
    include CanCan::ControllerAdditions
  end
end
