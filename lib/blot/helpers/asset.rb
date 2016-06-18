module Blot
  module Helpers
    module Asset
      def svg_tag(asset, fallback_format)
        svg = image_tag("#{asset}.svg", class: 'showy', width: 0, height: 0)
        fallback = image_tag("#{asset}.#{fallback_format}", class: 'no-showy')
        [svg, fallback].join.html_safe
      end
    end
  end
end
