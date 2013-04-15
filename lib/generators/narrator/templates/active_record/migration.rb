class NarratorMigration < ActiveRecord::Migration
  def change
    if table_exists?(:activities)
      say "Activities table already exists! Narrator was unable to install."
      raise "Narrator was unable to resolve clashing table names."
    else
      suppress_messages do
        create_table :activities do |t|
          t.belongs_to :owner
          t.belongs_to :actor
          t.text :context
          t.belongs_to :subject
          t.string :subject_type
          t.belongs_to :target
          t.string :target_type
          t.string :verb
          t.boolean :has_seen, default: false

          t.timestamps
        end
        add_index :activities, :owner_id
        add_index :activities, :actor_id
        add_index :activities, [:subject_id, :subject_type]
        add_index :activities, [:target_id, :target_type]
      end
      say "Created tables for Narrator"
    end
  end
end
