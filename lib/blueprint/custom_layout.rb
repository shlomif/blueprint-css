require "erb"
module Blueprint
  class CustomLayout
    CSS_ERB_FILE = File.join(Blueprint::LIB_PATH, "grid.css.erb")

    attr_accessor :column_count, :column_width, :gutter_width,
                  :input_padding, :input_border

    def column_count
      (@column_count || Blueprint::COLUMN_COUNT).to_i
    end

    def column_width
      (@column_width || Blueprint::COLUMN_WIDTH).to_i
    end

    def gutter_width
      (@gutter_width || Blueprint::GUTTER_WIDTH).to_i
    end

    def input_padding
      (@input_padding || Blueprint::INPUT_PADDING).to_i
    end

    def input_border
      (@input_border || Blueprint::INPUT_BORDER).to_i
    end

    def page_width
      self.column_count * (self.column_width + self.gutter_width) - self.gutter_width
    end

    def initialize(options = {})
      @column_count   = options[:column_count]
      @column_width   = options[:column_width]
      @gutter_width   = options[:gutter_width]
      @input_padding  = options[:input_padding]
      @input_border   = options[:input_border]
    end

    def default?
      self.column_width == Blueprint::COLUMN_WIDTH &&
      self.column_count == Blueprint::COLUMN_COUNT &&
      self.gutter_width == Blueprint::GUTTER_WIDTH &&
      self.input_padding == Blueprint::INPUT_PADDING &&
      self.input_border == Blueprint::INPUT_BORDER
    end

    def generate_grid_css
      css = ERB::new(File.path_to_string(CustomLayout::CSS_ERB_FILE))

      css.result(binding)
    end
  end
end
