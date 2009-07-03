require "test_helper"

class CustomLayoutTest < ActiveSupport::TestCase
  context "A custom layout instance" do
    setup do
      @custom_layout = Blueprint::CustomLayout.new
    end

    context "with default settings" do
      should "should be correct for column_count" do
        assert_equal Blueprint::COLUMN_COUNT.to_i, @custom_layout.column_count
      end

      should "should be correct for column_width" do
        assert_equal Blueprint::COLUMN_WIDTH.to_i, @custom_layout.column_width
      end

      should "should be correct for gutter_width" do
        assert_equal Blueprint::GUTTER_WIDTH.to_i, @custom_layout.gutter_width
      end

      should "should be correct for input_padding" do
        assert_equal Blueprint::INPUT_PADDING.to_i, @custom_layout.input_padding
      end

      should "should be correct for input_border" do
        assert_equal Blueprint::INPUT_BORDER.to_i, @custom_layout.input_border
      end

      should "be considered default" do
        assert @custom_layout.default?
      end
    end

    should "allow override of column_count" do
      @custom_layout.column_count = 12
      assert_equal 12, @custom_layout.column_count
      assert !@custom_layout.default?
    end

    should "allow override of column_width" do
      @custom_layout.column_width = 20
      assert_equal 20, @custom_layout.column_width
      assert !@custom_layout.default?
    end

    should "allow override of gutter_width" do
      @custom_layout.gutter_width = 25
      assert_equal 25, @custom_layout.gutter_width
      assert !@custom_layout.default?
    end

    should "allow override of input_padding" do
      @custom_layout.input_padding = 7
      assert_equal 7, @custom_layout.input_padding
      assert !@custom_layout.default?
    end

    should "allow override of input_border" do
      @custom_layout.input_border = 3
      assert_equal 3, @custom_layout.input_border
      assert !@custom_layout.default?
    end

    should "allow initialization with any specific widths" do
      options = {
        :column_count => 12,
        :column_width => 40,
        :gutter_width => 15,
        :input_padding => 8,
        :input_border => 2
      }
      @custom_layout = Blueprint::CustomLayout.new(options)
      assert_equal 12, @custom_layout.column_count
      assert_equal 40, @custom_layout.column_width
      assert_equal 15, @custom_layout.gutter_width
      assert_equal  8, @custom_layout.input_padding
      assert_equal  2, @custom_layout.input_border
    end

    should "properly calculate page width" do
      @custom_layout.column_count = 0
      @custom_layout.column_width = 15
      @custom_layout.gutter_width = 15
      assert_equal -15, @custom_layout.page_width

      @custom_layout.column_count = 1
      assert_equal 15, @custom_layout.page_width

      @custom_layout.column_count = 12
      @custom_layout.column_width = 20
      assert_equal 405, @custom_layout.page_width

      @custom_layout.column_count = 24
      @custom_layout.column_width = 30
      @custom_layout.gutter_width = 10
      assert_equal 950, @custom_layout.page_width
    end
  end
end
