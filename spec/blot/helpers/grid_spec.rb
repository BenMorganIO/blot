require 'spec_helper'

include ActionView::Helpers::AssetTagHelper

describe Blot::Helpers::Grid do
  let(:view) { ActionView::Base.new.extend subject }

  describe '.block_grid' do
    it 'can render a block-grid' do
      expect(view.block_grid up: :two).to eql <<-HTML.compress
        <table class="block-grid two-up">
          <tr></tr>
        </table>
      HTML
    end

    it 'can render a block-grid with classes' do
      expect(view.block_grid up: :two, class: 'row').to eql <<-HTML.compress
        <table class="block-grid two-up row">
          <tr></tr>
        </table>
      HTML
    end
  end

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

  describe '.panel_sub_grid' do
    it 'can render a panel sub-grid' do
      expect(view.panel_sub_grid).to eql <<-HTML.compress
        <td class="panel sub-grid">
          <table>
            <tr></tr>
          </table>
        </td>
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

    it 'can have text-padding' do
      expect(view.columns(:four, class: 'right-text-pad')).to eql <<-HTML.compress
        <table class="four columns">
          <tr>
            <td class="right-text-pad"></td>
            <td class="expander"></td>
          </tr>
        </table>
      HTML
    end
  end

  describe '.sub_columns' do
    it 'can render a sub-column' do
      expect(view.sub_column :one).to eql <<-HTML.compress
        <td class="one sub-columns"></td>
      HTML
    end

    it 'can render multiple sub-columns' do
      expect(view.sub_columns :two).to eql <<-HTML.compress
        <td class="two sub-columns"></td>
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

  context 'example' do
    it 'can render two rows, twelve and six by six' do
      example = view.container do
        view.row do
          view.wrapper(class: 'wrapper last') do
            view.columns(:twelve, class: 'panel') { '.twelve.columns' }
          end
        end +
        view.row do
          view.wrapper(class: 'wrapper') do
            view.columns(:six, class: 'panel') { '.six.columns' }
          end +
          view.wrapper(class: 'wrapper last') do
            view.columns(:six, class: 'panel') { '.six.columns' }
          end
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="container">
          <tr>
            <td>

              <table class="row">
                <tr>
                  <td class="wrapper last">

                    <table class="twelve columns">
                      <tr>
                        <td class="panel">.twelve.columns</td>
                        <td class="expander"></td>
                      </tr>
                    </table>

                  </td>
                </tr>
              </table>

              <table class="row">
                <tr>
                  <td class="wrapper">

                    <table class="six columns">
                      <tr>
                        <td class="panel">.six.columns</td>
                        <td class="expander"></td>
                      </tr>
                    </table>

                  </td>
                  <td class="wrapper last">

                    <table class="six columns">
                      <tr>
                        <td class="panel">.six.columns</td>
                        <td class="expander"></td>
                      </tr>
                    </table>

                  </td>
                </tr>
              </table>

            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render centered content' do
      example = view.row do
        view.wrapper(class: 'wrapper') do
          view.columns(:six, class: 'center panel') { 'Centered content' }
        end +
        view.wrapper(class: 'wrapper last') do
          view.columns(:six, class: 'center panel') do
            image_tag 'http://placehold.it/125x125&text=Centered%20Image', class: 'center', alt: 'centered image'
          end
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="row">
          <tr>
            <td class="wrapper">

              <table class="six columns">
                <tr>
                  <td class="center panel">
                    <center>Centered content</center>
                  </td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
            <td class="wrapper last">

              <table class="six columns">
                <tr>
                  <td class="center panel">
                    <center><img alt="centered image" class="center" src="http://placehold.it/125x125&amp;text=Centered%20Image" /></center>
                  </td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render offset columns' do
      example = view.row do
        view.wrapper(class: 'wrapper offset-by-four') do
          view.columns(:eight, class: 'panel') { 'Offset Content' }
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="row">
          <tr>
            <td class="wrapper offset-by-four">
            
              <table class="eight columns">
                <tr>
                  <td class="panel">Offset Content</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render text-padding' do
      example = view.row do
        view.wrapper(class: 'wrapper') do
          view.columns(:four, class: 'left-text-pad') { 'Text' }
        end +
        view.wrapper(class: 'wrapper') do
          view.columns(:four) { 'Text' }
        end +
        view.wrapper(class: 'wrapper last') do
          view.columns(:four, class: 'right-text-pad') { 'Text' }
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="row">
          <tr>
            <td class="wrapper">

              <table class="four columns">
                <tr>
                  <td class="left-text-pad">Text</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
            <td class="wrapper">

              <table class="four columns">
                <tr>
                  <td>Text</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
            <td class="wrapper last">

              <table class="four columns">
                <tr>
                  <td class="right-text-pad">Text</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render full-width rows' do
      example = view.row do
        view.wrapper(class: 'center', align: 'center') do
          view.container(class: 'wrapper last') do
            view.columns(:twelve) { 'Content' }
          end
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="row">
          <tr>
            <td align="center" class="center">
              <center>

                <table class="container">
                  <tr>
                    <td class="wrapper last">

                      <table class="twelve columns">
                        <tr>
                          <td>Content</td>
                          <td class="expander"></td>
                        </tr>
                      </table>

                    </td>
                  </tr>
                </table>

              </center>
            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render a sub-grid' do
      example = view.row do
        view.wrapper(class: 'wrapper') do
          view.columns(:eight, sub_columns: true) do
            view.sub_columns(:eight) { '.eight.sub-columns' } +
            view.sub_columns(:four, class: 'last') { '.four.sub-columns' }
          end
        end +
        view.wrapper(class: 'wrapper last') do
          view.columns(:four) { '.four.columns' }
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="row">
          <tr>
            <td class="wrapper">

              <table class="eight columns">
                <tr>
                  <td class="eight sub-columns">.eight.sub-columns</td>
                  <td class="four sub-columns last">.four.sub-columns</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
            <td class="wrapper last">

              <table class="four columns">
                <tr>
                  <td>.four.columns</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render a block-grid' do
      example = view.container do
        view.block_grid(up: :two) do
          view.wrapper { 'Column #1' } +
          view.wrapper { 'Column #2' }
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="container">
          <tr>
            <td>

              <table class="block-grid two-up">
                <tr>
                  <td>Column #1</td>
                  <td>Column #2</td>
                </tr>
              </table>

            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render a sidebar' do
      example = view.row do
        view.wrapper(class: 'wrapper') do
          view.columns(:eight) { 'Main content' }
        end +
        view.wrapper(class: 'wrapper last') do
          view.columns(:four, class: 'panel') { 'Panel content' }
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="row">
          <tr>
            <td class="wrapper">

              <table class="eight columns">
                <tr>
                  <td>Main content</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
            <td class="wrapper last">

              <table class="four columns">
                <tr>
                  <td class="panel">Panel content</td>
                  <td class="expander"></td>
                </tr>
              </table>

            </td>
          </tr>
        </table>
      HTML
    end

    it 'can render a panel with a sub-grid' do
      example = view.columns(:twelve, class: 'panel sub-grid', sub_columns: true) do
        view.panel_sub_grid do
          view.sub_columns(:six) { 'Left Sub-Column' } +
          view.sub_columns(:six) { 'Right Sub-Column' }
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="twelve columns">
          <tr>
            <td class="panel sub-grid">

              <table>
                <tr>
                  <td class="six sub-columns">Left Sub-Column</td>
                  <td class="six sub-columns">Right Sub-Column</td>
                </tr>
              </table>

            </td>
            <td class="expander"></td>
          </tr>
        </table>
      HTML
    end
  end
end
