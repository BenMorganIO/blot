require 'spec_helper'

describe Blot::Helpers do
  subject { Class.new.include Blot::Helpers }

  it { should include Blot::Helpers::Layout }
  it { should include Blot::Helpers::Grid }
  it { should include Blot::Helpers::Visibility }
  it { should include Blot::Helpers::Button }
end
