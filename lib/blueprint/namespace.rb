module Blueprint
  class Namespace

    def initialize(path, namespace)
      html = File.path_to_string(path)
      remove_current_namespace(html)
      add_namespace(html, namespace)
      File.string_to_file(html, path)
    end

    def add_namespace(html, namespace)
      html.gsub!(/(class=")([a-zA-Z0-9\-_ ]*)(")/) do |m|
        classes = m.to_s.split('"')[1].split(" ")
        classes.map! { |c| c = namespace + c }
        'class="' + classes.join(' ') + '"'
      end
      html
    end

    def remove_current_namespace(html)
      current = current_namespace(html)
      html.gsub!(current, "")
      html
    end

    def current_namespace(html)
      html =~ /class="([\S]+)container/
      current_namespace = $1 if $1
      current_namespace || ""
    end
  end
end
