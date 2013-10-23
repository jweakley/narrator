module Narrator
  class NarratorRailtie < Rails::Railtie
    initializer 'narrator.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end
