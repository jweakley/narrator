module Narrator
  module ModelAdditions
    include ::ActiveSupport::Inflector
    def narratable_model
      ###
      # Includes
      ###
      include Narrator::ModelResources

      ###
      # Associations
      ###
      has_many  :activities,
                as: :subject,
                class_name: 'Narrator::Activity',
                dependent: :destroy

      ###
      # Instance Methods
      ###

      def track_user_activity(
        subject_id,
        subject_class,
        actor_id,
        actor_class,
        target_id,
        target_class,
        verb,
        context
      )
        actor = actor_id.blank? ? nil : actor_class.constantize.find_by_id(actor_id)
        subject = subject_id.blank? ? nil : subject_class.constantize.find_by_id(subject_id)
        target = target_id.blank? ? nil : target_class.constantize.find_by_id(target_id)
        Narrator::Activity.create!(
          owner: nil,
          subject: subject,
          actor: actor,
          target: target,
          verb: verb,
          context: context
        )
      end
    end

    def narratable_actor
      ###
      # Associations
      ###
      has_many  :activities,
                as: :actor,
                class_name: 'Narrator::Activity',
                dependent: :destroy
    end
  end
end
