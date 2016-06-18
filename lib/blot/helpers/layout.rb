module Blot
  module Helpers
    module Layout
      def layout(options={})
        doctype = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
        html = content_tag :html, xmlns: 'http://www.w3.org/1999/xhtml' do
          head = content_tag :head do
            content_type = tag :meta, 'http-equiv' => 'Content-Type', content: 'text/html; charset=utf-8'
            viewport     = tag :meta, name: 'viewport', content: 'width=device-width'

            ink          = content_tag :style, rel: 'text/css' do
              Rails.application.assets[options[:ink]].to_s.html_safe
            end if options[:ink]

            styles       = content_tag :style, rel: 'text/css' do
              app_styles = []
              options[:styles].each do |style|
                app_styles << Rails.application.assets[style].to_s.html_safe
              end
              app_styles.join(' ').html_safe
            end if options[:styles]

            ignored_styles = content_tag :style, rel: 'text/css', 'data-premailer' => 'ignore' do
              <<-CSS.squish
                /* Resize an element that has a width and height of zero to full size */
                .showy {
                  height: 100% !important;
                  width: 100% !important;
                }

                /* Hide this everywhere, except for those that can’t read this code */
                .no-showy {
                  display: none;
                }
              CSS
            end

            [content_type, viewport, ink, styles, ignored_styles].join.html_safe
          end

          body = content_tag :body do
            content_tag :table, class: 'body' do
              content_tag :tr do
                content_tag :td, class: 'center', align: 'center', valign: 'top' do
                  content_tag :center do
                    yield.try(:html_safe) if block_given?
                  end
                end
              end
            end
          end

          [head, body].join.html_safe
        end

        [doctype, html].join.html_safe
      end
    end
  end
end
