require 'spec_helper'

describe Blot::Helpers::Button do
  let(:view) { ActionView::Base.new.extend subject }

  describe '.button' do
    it 'simple button' do
      expect(view.button('Button Label', '#', size: :button)).to eql <<-HTML.compress
        <table class="button">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'tiny button' do
      expect(view.button('Button Label', '#', size: :tiny)).to eql <<-HTML.compress
        <table class="tiny-button">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'small button' do
      expect(view.button('Button Label', '#', size: :small)).to eql <<-HTML.compress
        <table class="small-button">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'medium button' do
      expect(view.button('Button Label', '#', size: :medium)).to eql <<-HTML.compress
        <table class="medium-button">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'large button' do
      expect(view.button('Button Label', '#', size: :large)).to eql <<-HTML.compress
        <table class="large-button">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'primary button' do
      expect(view.button('Button Label', '#', size: :button, color: :primary)).to eql <<-HTML.compress
        <table class="button primary">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'secondary button' do
      expect(view.button('Button Label', '#', size: :button, color: :secondary)).to eql <<-HTML.compress
        <table class="button secondary">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'alert button' do
      expect(view.button('Button Label', '#', size: :button, color: :alert)).to eql <<-HTML.compress
        <table class="button alert">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'success button' do
      expect(view.button('Button Label', '#', size: :button, color: :success)).to eql <<-HTML.compress
        <table class="button success">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'radius button' do
      expect(view.button('Button Label', '#', size: :button, radius: :radius)).to eql <<-HTML.compress
        <table class="button radius">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'round button' do
      expect(view.button('Button Label', '#', size: :button, radius: :round)).to eql <<-HTML.compress
        <table class="button round">
          <tr>
            <td>
              <a href="#">Button Label</a>
            </td>
          </tr>
        </table>
      HTML
    end
  end
end
