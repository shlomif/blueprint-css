require "test_helper"

class CoreExtTest < ActiveSupport::TestCase
  context "Nil" do
    should "respond to blank?" do
      assert nil.blank?
    end
  end

  context "File" do
    should "turn a path to a string" do
      filename = "junk"
      file = stub
      file.expects(:read).returns("content")
      File.expects(:new).with(filename).returns(file)
      assert_equal "content", File.path_to_string(filename)
    end

    should "turn a string to a path" do
      str = "css string"
      path = "path"
      directory = "/path/to/directory"

      File.expects(:dirname).with(path).returns(directory)
      File.expects(:directory?).with(directory).returns(false)
      FileUtils.expects(:mkdir_p).with(directory)

      File.expects(:open).with(path, "w")
      File.string_to_file(str, path)
    end
  end

  context "String" do
    should "respond to blank?" do
      str = "string"
      str.expects(:length).returns(0)
      assert str.blank?
    end

    should "know how to strip spaces" do
      str1 = ":     "
      assert_equal ":", str1.strip_space!

      str2 = "\n\n\n"
      assert_equal "", str2.strip_space!

      str3 = "     "
      assert_equal " ", str3.strip_space!

      str4 = %(words/*    more commented words  */)
      assert_equal "words", str4.strip_space!
    end

    should "know how to strip selector spaces" do
      str1 = "\n\n\n"
      assert_equal "", str1.strip_selector_space!

      str2 = ".selector,.one"
      assert_equal ".selector, .one", str2.strip_selector_space!

      str3 = ".two,    .three"
      assert_equal ".two, .three", str3.strip_selector_space!
    end

    should "know how to strip side space" do
      str1 = "  .side"
      assert_equal ".side", str1.strip_side_space!

      str2 = ".side      "
      assert_equal ".side\n", str2.strip_side_space!
    end
  end
end
