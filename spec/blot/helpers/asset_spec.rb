require 'spec_helper'

describe Blot::Helpers::Asset do
  let(:view) { ActionView::Base.new.extend subject }

  describe '.svg_tag' do
    it 'will provide an img for the svg and a second img as a fallback' do
      expect(view.svg_tag('logo', :png)).to eql <<-HTML.compress
        <img class="showy" width="0" height="0" src="/images/logo.svg" alt="Logo" />
        <img class="no-showy" src="/images/logo.png" alt="Logo" />
      HTML
    end
  end
end
