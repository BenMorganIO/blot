require 'spec_helper'

include Blot::Helpers::Grid

describe Blot::Helpers::Visibility do
  let(:view) { ActionView::Base.new.extend subject }

  it '#show_for_small' do
    expect(view.show_for_small).to eql <<-HTML.compress
      <!--[if !mso]><!-- -->
        <table class="show-for-small">
          <tr>
            <td></td>
          </tr>
        </table>
      <!--<![endif]-->
    HTML
  end

  it '#hide_for_small' do
    expect(view.hide_for_small).to eql <<-HTML.compress
      <table class="hide-for-small">
        <tr>
          <td></td>
        </tr>
      </table>
    HTML
  end

  context 'example' do
    it 'can render visibility of columns in a row' do
      example = view.row do
        view.wrapper(class: 'wrapper last') do
          view.show_for_small do
            view.columns(:twelve, class: 'panel') { '.show-for-small' }
          end +
          view.hide_for_small do
            view.columns(:twelve, class: 'panel') { '.hide-for-small' }
          end
        end
      end

      expect(example).to eql <<-HTML.compress
        <table class="row">
          <tr>
            <td class="wrapper last">

              <!--[if !mso]><!-- -->
                <table class="show-for-small">
                  <tr>
                    <td>

                      <table class="twelve columns">
                        <tr>
                          <td class="panel">.show-for-small</td>
                          <td class="expander"></td>
                        </tr>
                      </table>
                      
                    </td>
                  </tr>
                </table>
              <!--<![endif]-->

              <table class="hide-for-small">
                <tr>
                  <td>

                    <table class="twelve columns">
                      <tr>
                        <td class="panel">.hide-for-small</td>
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
  end
end
