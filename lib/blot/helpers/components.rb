module Blot
  module Helpers
    module Components
      def section
        row do
          wrapper(class: 'last') { yield if block_given? }
        end
      end

      def panel_section
        section do
          columns(:twelve, class: 'panel center') { yield if block_given? }
        end
      end
    end
  end
end
