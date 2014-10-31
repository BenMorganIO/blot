require 'spec_helper'

describe Blot::Helpers::Grid do
  let(:view) { ActionView::Base.new.extend subject }

  describe '.container' do
    it 'can render an empty container' do
      expect(view.container).to eql <<-HTML.compress
        <table class="container">
          <tr>
            <td></td>
          </tr>
        </table>
      HTML
    end

    it 'can render an empty centered container' do
      expect(view.container(class: 'center')).to eql <<-HTML.compress
        <table class="container">
          <tr>
            <td class="center">
              <center></center>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render a centered tag with content' do
      expect(view.container(class: 'center') { " Content " }).to eql <<-HTML.compress
        <table class="container">
          <tr>
            <td class="center">
              <center>
                Content
              </center>
            </td>
          </tr>
        </table>
      HTML
    end
  end

  describe '.row' do
    it 'can render an empty row' do
      expect(view.row).to eql <<-HTML.compress
        <table class="row">
          <tr></tr>
        </table>
      HTML
    end
  end

  describe '.wrapper' do
    it 'can render an empty wrapper' do
      expect(view.wrapper).to eql <<-HTML.compress
        <td></td>
      HTML
    end
  end

  describe '.columns' do
  end
end
