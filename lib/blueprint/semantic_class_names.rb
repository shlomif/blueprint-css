module Blueprint
  class SemanticClassNames
    attr_accessor :class_assignments
    attr_reader   :namespace, :source_file

    def initialize(options = {})
      @namespace = options[:namespace] || ""
      @source_file =  options[:source_file] ||
                      File.join(Blueprint::BLUEPRINT_ROOT_PATH, "screen.css")
      self.class_assignments = options[:class_assignments] || {}
    end

    def css_from_assignments(assignments = {})
      assignments ||= self.class_assignments

      output_css = {}
      css_to_parse = File.path_to_string(self.source_file)
      blueprint_assignments = CSSParser.new(css_to_parse).parse

      assignments.each do |semantic_class, blueprint_classes|
        blueprint_classes = blueprint_classes.split(/,|\s/).reject(&:blank?).map(&:strip)
        classes = []
        blueprint_classes.each do |bp_class|
          match = if bp_class.include?(".")
                    bp_class.gsub(".", ".#{self.namespace}")
                  else
                    ".#{self.namespace}#{bp_class}"
                  end
          classes << blueprint_assignments.find_all do |line|
            line[:tags] =~ Regexp.new(/^([\w\.\-\:]+, ?)*#{match}(, ?[\w\.\-\:]+)*$/)
          end.uniq
        end

        classes = classes.flatten.uniq
        output_css[semantic_class] = "#{classes.sort_by {|i| i[:idx]}.map {|i| i[:rules]}}"
      end

      css = ""
      output_css.each do |tags, rules|
        css += "#{tags} {#{rules}}\n"
      end
      css
    end
  end
end
