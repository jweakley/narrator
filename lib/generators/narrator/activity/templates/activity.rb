class Activity
    include Narrator::Activity
    ###
    # Attribute accessible
    ###
      attr_accessible :owner, :subject, :actor, :target, :target_id, :target_type, :verb, :context, :has_seen

    ###
    # Associations
    ###
      belongs_to :owner, class_name: 'UserProfile'
      belongs_to :actor, class_name: 'UserProfile'
      belongs_to :subject, polymorphic: true
      belongs_to :target, polymorphic: true

    ###
    # Validate
    ###
      validates :owner, presence: true
      validates :subject, presence: true
      validates :verb, presence: true

    ###
    # Scopes
    ###
      scope :unseen, where{has_seen.eq false}
      scope :seen, where{has_seen.eq true}
      scope :recent, order('created_at DESC')

end
