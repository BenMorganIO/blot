require 'spec_helper'

describe Blot::VERSION do
  it { should be_a String }

  it 'should be semantically versioned' do
    expect(subject.split('.')).to have(3).items
  end
end
