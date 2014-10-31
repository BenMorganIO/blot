module Blot
  module Helpers
    module Grid
      def container(options={})
        content_tag :table, class: 'container' do
          content_tag :tr do
            content_tag :td, options do
              options[:class] == 'center' ? content_tag(:center, yield) : yield
            end
          end
        end
      end

      def row
        content_tag :table, class: 'row' do
          content_tag :tr do
            yield if block_given?
          end
        end
      end

      def wrapper(options={}, &block)
        content_tag :td, options do
          if block_given?

            options[:class] == 'center' ? content_tag(:center, yield) : yield

          end
        end
      end

      def columns(width, options={})
        content_tag :table, class: "#{width} columns" do
          content_tag :tr do
            content_tag :td, options do
              if block_given?

                options[:class] == 'center' ? content_tag(:center, yield) : yield

              end
            end
            content_tag :td, class: 'expander'
          end
        end
      end
      alias :column :columns
    end
  end
end
