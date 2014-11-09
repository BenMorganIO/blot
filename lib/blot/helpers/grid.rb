module Blot
  module Helpers
    module Grid
      def block_grid(options={})
        options[:class] = "block-grid #{options[:up]}-up #{options[:class]}".strip
        content_tag :table, class: options[:class] do
          content_tag :tr do
            yield if block_given?
          end
        end
      end

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

      def panel_sub_grid
        content_tag :td, class: 'panel sub-grid' do
          content_tag :table do
            content_tag :tr do
              yield if block_given?
            end
          end
        end
      end

      def columns(width, options={})
        content_tag :table, class: "#{width} columns" do
          content_tag :tr do
            content = if options[:sub_columns]
              block_given? ? yield : nil
            elsif !options.empty? || block_given?
              wrapper(options) { yield if block_given? }
            else
              nil
            end

            [content, expander].join('').html_safe
          end
        end
      end
      alias :column :columns

      def sub_columns(width, options={})
        options[:class] = "#{width} sub-columns #{options[:class]}".strip
        wrapper(options) { yield if block_given? }
      end
      alias :sub_column :sub_columns

      def wrapper(options={}, &block)
        content_tag :td, options do
          optional_content(options) { yield if block_given? }
        end
      end

      private

      def expander
        content_tag :td, nil, class: 'expander'
      end

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
