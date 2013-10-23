module Narrator
  class Activity < ::ActiveRecord::Base
    attr_accessible :owner,
                    :subject,
                    :actor,
                    :target,
                    :verb,
                    :context,
                    :has_seen

    belongs_to :owner, polymorphic: true
    belongs_to :actor, polymorphic: true
    belongs_to :subject, polymorphic: true
    belongs_to :target, polymorphic: true

    validates :subject, presence: true
    validates :verb, presence: true

    scope :unseen, where(has_seen: false)
    scope :seen, where(has_seen: true)
  end
end
