class String
  def blank?
    self.length.zero?
  end

  def strip_space!
    replace self.
      gsub(/:\s*/, ":").
      gsub(/\n/, "").
      gsub(/\s+/, " ").
      gsub(/(\/\*).*?(\*\/)/, "")
  end

  def strip_selector_space!
    replace self.
      gsub(/\n/, "").
      gsub(/,\s*/, ", ")
  end

  def strip_side_space!
    replace self.
      gsub(/^\s+/, "").
      gsub(/\s+$/, $/)
  end
end

class NilClass
  def blank?
    true
  end
end

class File
  def self.path_to_string(path)
    File.new(path).read
  end

  def self.string_to_file(string, path)
    directory = File.dirname(path)
    FileUtils.mkdir_p directory unless File.directory?(directory)
    File.open(path, "w") {|file| file << string }
  end
end
