module Blot
  module Helpers
    module Grid
      def container(options={})
        content_tag :table, class: 'container' do
          content_tag :tr do
            wrapper(options) { yield if block_given? }
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

      def columns(width, options={})
        content_tag :table, class: "#{width} columns" do
          content_tag :tr do
            "#{wrapper(options) { yield if block_given? } if !options.empty? || block_given? }" \
            "#{content_tag :td, nil, class: 'expander'}".html_safe
          end
        end
      end
      alias :column :columns

      def wrapper(options={}, &block)
        content_tag :td, options do
          optional_content(options) { yield if block_given? }
        end
      end

      private

      def optional_content(options={}, &block)
        if options[:class] && options[:class].split(' ').include?('center')
          content_tag :center, block.call
        else
          block.call
        end
      end
    end
  end
end
