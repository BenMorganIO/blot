require 'spec_helper'

describe Blot::Railtie do
  it 'should include helpers in action mailer' do
    Blot::Railtie.send(:new).run_initializers
    expect(ActionMailer::Base._helpers).to include Blot::Helpers
  end
end
