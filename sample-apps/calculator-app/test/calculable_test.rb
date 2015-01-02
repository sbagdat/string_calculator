require 'test_helper'

module TestCalculable
  class TestInput < Minitest::Test
    include Calculable

    def setup
      @input = Input.new
    end

    def test_it_creates_new_instance
      assert_instance_of Input, @input
    end

    def test_instantiating_without_an_initial_value_content_stays_blank
      assert_empty @input.content
    end

    def test_instantiating_with_a_valid_initial_value_it_saved_as_content
      input = Input.new('1+2')
      assert_equal '1+2', input.content
    end

    def test_instantiating_with_an_invalid_initial_value_raises_an_error
      assert_raises(InvalidContentError) { Input.new('1+2invalid') }
    end

    def test_changing_content_with_an_invalid_value_using_setter_method
      assert_raises(InvalidContentError) { @input.content = '1+2invalid' }
    end

    def test_changing_content_with_a_valid_value_using_setter_method
      @input.content = '1+2*8/7'
      assert_equal '1+2*8/7', @input.content
    end

    def test_content_cant_start_with_a_multiplication_or_division_operator
      assert_content_fails %w( *12+36 /12+36 + )
    end

    def test_content_cant_start_with_multiple_addition_or_subtraction_operator
      assert_content_fails %w( ++123 --456 -+78 +-+910 )
    end

    def test_content_cant_end_with_a_character_other_than_a_number
      assert_content_fails %w( 1+2* 1+2/ 1+2- 1+2+ )
    end

    def test_content_cant_contain_consecutive_multiplication_or_division
      assert_content_fails %w( 1**2 1//2 1*/2 1/*2)
    end

    def test_content_cant_contain_any_triple_or_more_consecutive_operator
      assert_content_fails %w( 1*++2 1++/2/ 1+*/2/ 1+-*-2/)
    end

    def test_content_has_wrong_ordered_operators_raises_an_error
      assert_content_fails %w( 1+*2 1-*2 1+/2 1-/2)
    end

    private

    def assert_content_fails(contents)
      assert contents.all? { |c|
               assert_raises(InvalidContentError) { @input.content = c }
             }
    end
  end
end
