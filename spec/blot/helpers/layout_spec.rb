require 'spec_helper'

describe Blot::Helpers::Layout do
  let(:view) { ActionView::Base.new.extend subject }

  it 'can render a boilerplate' do
    example = view.layout { '<!-- Email Content -->' }

    expect(example).to eql <<-HTML.compress
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
          <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
          <meta content="width=device-width" name="viewport" />
        </head>
        <body>
          <table class="body">
            <tr>
              <td align="center" class="center" valign="top">
                <center>

                <!-- Email Content -->

                </center>
              </td>
            </tr>
          </table>
        </body>
      </html>
    HTML
  end

  it 'can work with nil content' do
    expect { view.layout { } }.not_to raise_error
  end

  it 'can render styles' do
    assets = { assets: { 'ink.css' => 'Ink Styles!', 'typography.css' => 'Typography Styles!', 'colors.css' => 'Color Styles!' } }
    allow(Rails).to receive_messages(application:  OpenStruct.new(assets))
    example = view.layout(ink: 'ink.css', styles: ['typography.css', 'colors.css'])

    expect(example).to eql <<-HTML.compress
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
          <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
          <meta content="width=device-width" name="viewport" />
          <style rel="text/css">Ink Styles!</style>
          <style rel="text/css">Typography Styles! Color Styles!</style>
        </head>
        <body>
          <table class="body">
            <tr>
              <td align="center" class="center" valign="top">
                <center></center>
              </td>
            </tr>
          </table>
        </body>
      </html>
    HTML
  end
end
