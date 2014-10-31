require 'blot/helpers'

module Blot
  class Railtie < Rails::Railtie
    # include our helpers for the emails
    initializer "blot.helpers" do
      ActionMailer::Base.send :add_template_helper, Helpers
    end
  end
end
