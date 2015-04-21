require 'spec_helper'

describe Blot::Helpers::Components do
  let(:view) { ActionView::Base.new.extend subject }

  it '#section' do
    expect(view.section).to eql <<-HTML.compress
      <table class="row">
        <tr>
          <td class="wrapper last"></td>
        </tr>
      </table>
    HTML
  end

  it '#panel_section' do
    expect(view.panel_section).to eql <<-HTML.compress
      <table class="row">
        <tr>
          <td class="wrapper last">

            <table class="twelve columns">
              <tr>
                <td class="panel center">

                  <center></center>

                </td>
                <td class="expander"></td>
              </tr>
            </table>

          </td>
        </tr>
      </table>
    HTML
  end
end
