module Blot
  module Helpers
    module Button
      def button(label, path, options={})
        size   = options.delete(:size).to_s
        size  += '-button' if size != 'button'
        color  = options.delete :color
        radius = options.delete :radius

        content_tag :table, class: "#{size} #{color} #{radius}".squish do
          content_tag :tr do
            content_tag :td do
              link_to label, path, options
            end
          end
        end
      end
    end
  end
end
