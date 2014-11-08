module Blot
  module Helpers
    module Visibility
      def show_for_small
        ('<!--[if !mso]><!-- -->' +
        content_tag(:table, class: 'show-for-small') do
          content_tag :tr do
            content_tag :td do
              yield if block_given?
            end
          end
        end +
        '<!--<![endif]-->').html_safe
      end

      def hide_for_small
        content_tag :table, class: 'hide-for-small' do
          content_tag :tr do
            content_tag :td do
              yield if block_given?
            end
          end
        end
      end
    end
  end
end
