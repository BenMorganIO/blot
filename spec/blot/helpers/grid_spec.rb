require 'spec_helper'

describe Blot::Helpers::Grid do
  let(:view) { ActionView::Base.new.extend subject }

  describe '.container' do
    it 'can render a container' do
      expect(view.container).to eql <<-HTML.compress
        <table class="container">
          <tr>
            <td></td>
          </tr>
        </table>
      HTML
    end
  end

  describe '.row' do
    it 'can render a row' do
      expect(view.row).to eql <<-HTML.compress
        <table class="row">
          <tr></tr>
        </table>
      HTML
    end
  end

  describe '.columns' do
    it 'can render one column' do
      expect(view.column :one).to eql <<-HTML.compress
        <table class="one columns">
          <tr>
            <td class="expander"></td>
          </tr>
        </table>
      HTML
    end

    it 'can render multiple columns' do
      expect(view.columns :two).to eql <<-HTML.compress
        <table class="two columns">
          <tr>
            <td class="expander"></td>
          </tr>
        </table>
      HTML
    end
  end

  describe '.wrapper' do
    it 'can be empty' do
      expect(view.wrapper).to eql <<-HTML.compress
        <td></td>
      HTML
    end

    it 'can yield content' do
      expect(view.wrapper { "Content" }).to eql <<-HTML.compress
        <td>Content</td>
      HTML
    end

    it 'can have a class' do
      expect(view.wrapper(class: 'wrapper') { 'Content' }).to eql <<-HTML.compress
        <td class="wrapper">Content</td>
      HTML
    end

    it 'can have multiple classes' do
      expect(view.wrapper(class: 'wrapper last') { 'Content' }).to eql <<-HTML.compress
        <td class="wrapper last">Content</td>
      HTML
    end
  end

  context 'private' do
    describe '.optional_content' do
      it 'can center content' do
        oc = view.send(:optional_content, class: 'center') { "Content" }
        expect(oc).to eql <<-HTML.compress
          <center>Content</center>
        HTML
      end
    end
  end
end
