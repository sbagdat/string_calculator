require 'test_helper'
require 'calculator'

class TestCalculator < Minitest::Test
  def setup
    @calc = Calculator.new
  end

  def test_it_creates_new_instance
    assert_instance_of Calculator, @calc
  end

  def test_input_can_be_assigned_when_it_is_instantiating
    calc = Calculator.new('-3+8*7')
    assert_equal '-3+8*7', calc.input
  end

  def test_input_can_be_changed_after_instantiating
    @calc.input = '27+968'
    assert_equal '27+968', @calc.input
  end

  def test_empty_string_input_returns_zero
    @calc.input = '  '
    assert_equal 0.0, @calc.calculate
  end

  def test_only_number_input_returns_itself
    inputs = %w( 61 -53 +212 )
    refute inputs.any? { |i| Calculator.new(i).calculate != i.to_f }
  end

  def test_addition
    @calc.input = '23+50+27+80'
    assert_equal 23 + 50 + 27 + 80, @calc.calculate
  end

  def test_subtraction
    @calc.input = '100-50-13'
    assert_equal 100 - 50 - 13, @calc.calculate
  end

  def test_addition_and_subtraction
    @calc.input = '100+50-13'
    assert_equal 100 + 50 - 13, @calc.calculate
  end

  def test_multiplication
    @calc.input = '5*4*3*2*1'
    assert_equal 5 * 4 * 3 * 2 * 1, @calc.calculate
  end

  def test_division_of_exact_dividible_numbers
    @calc.input = '15/5'
    assert_equal 15.0 / 5, @calc.calculate
  end

  def test_division_of_not_exact_dividible_numbers
    @calc.input = '15 / 7'
    assert_equal 15.0 / 7, @calc.calculate
  end

  def test_division_of_multiple_numbers
    @calc.input = '15/7/3'
    assert_equal 15.0 / 7 / 3, @calc.calculate
  end

  def test_division_to_zero_returns_infinity
    @calc.input = '15/0/3'
    assert_equal 'Infinity', @calc.calculate
  end

  def test_four_operations_in_the_same_input
    @calc.input = '15*7/4-5+28'
    assert_equal 15.0 * 7 / 4 - 5 + 28, @calc.calculate
  end

  def test_negative_results
    @calc.input = '-3-5/98+25-32*7'
    assert_equal(-3 - 5.0 / 98 + 25 - 32 * 7, @calc.calculate)
  end
end
