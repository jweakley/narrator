module Narrator
  class Activity < ::ActiveRecord::Base
    ###
    # Attribute accessible
    ###
      attr_accessible :owner, :subject, :actor, :target, :verb, :context, :has_seen

    ###
    # Associations
    ###
      belongs_to :owner, polymorphic: true
      belongs_to :actor, polymorphic: true
      belongs_to :subject, polymorphic: true
      belongs_to :target, polymorphic: true

    ###
    # Validate
    ###
      validates :subject, presence: true
      validates :verb, presence: true

    ###
    # Scopes
    ###
      scope :unseen, where(has_seen: false)
      scope :seen, where(has_seen: true)
  end
end
