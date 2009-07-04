module Blueprint
  class CSSParser
    attr_accessor :namespace
    attr_reader   :css_output, :raw_data

    def initialize(css_string = "", options = {})
      @raw_data     = css_string
      @namespace    = options[:namespace] || ""
      compress(@raw_data)
    end

    def to_s
      @css_output
    end

    def parse(data = nil)
      data ||= @raw_data

      css_out = []
      data.strip_side_space!.strip_space!

      data.split('}').each_with_index do |assignments, index|
        tags, styles = assignments.split("{").map {|a| a.strip_side_space! }
        next if styles.blank?

        tags.strip_selector_space!
        tags.gsub!(/\./, ".#{namespace}") unless namespace.blank?

        rules = []
        styles.split(";").each do |key_val_pair|
          next if key_val_pair.nil?
          property, value = key_val_pair.split(":", 2).map {|kv| kv.strip_side_space! }
          break unless property && value
          rules << "#{property}:#{value};"
        end
        # now keeps track of index as hashes don't keep track of
        # position (which will be fixed in Ruby 1.9)
        unless tags.blank? || rules.empty?
          css_out << {:tags => tags, :rules => rules.to_s, :idx => index}
        end
      end
      css_out
    end

    private

    def compress(data)
      @css_output = ""
      parse(data).flatten.sort_by {|i| i[:idx] }.each do |line|
        @css_output += "#{line[:tags]} {#{line[:rules]}}\n"
      end
    end
  end
end
