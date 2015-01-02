require_relative "calculable"

class Calculator
  include Calculable

  OPERATIONS           = [:*, :/, :-, :+]
  OPERAND_REGEXP       = /(?<![0-9])([\+\-]?(\d+(\.\d+)?))/

  def initialize(input = '')
    @input = Input.new(input)
  end

  def input
    @input.content
  end

  def input= input
    @input.content = input
  end

  def calculate
    perform_calculation
  end

  private

  def perform_calculation
    return 0 if input.empty?

    OPERATIONS.each do |operation|
      op_regexp       = Regexp.escape(operation)
      operable_regexp = /#{OPERAND_REGEXP}#{op_regexp}#{OPERAND_REGEXP}/

      while input.match(/#{op_regexp}/)
        break unless input.match(operable_regexp)
        input.gsub!(operable_regexp) do |matching|
          matching = matching.split(/#{op_regexp}/).map(&:to_f).inject(operation)
        end
      end

    end

    input.include?("Infinity") ? "Infinity" : input.to_f
  end
end
