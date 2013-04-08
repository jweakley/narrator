module Narrator
  module Generators
    class ActivityGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def generate_ability
        copy_file "activity.rb", "app/models/activity.rb"
      end
    end
  end
end
