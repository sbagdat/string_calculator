module Calculable
  INPUT_INVALID_REGEXP = /
      ^([\/\*]|[\+\-]{2}) | # cannot start with a multiplication or division operator, or
                            # cannot start with more than two addition or subtraction operator
      [^0-9]$ |             # cannot end with a character other than a number
      [^0-9\+\-\*\/] |      # cannot contain any character other than numbers or operators
      [\*\/]{2}      |      # cannot contain two multiplication or division operators consecutively
      [\+\-\*\/]{3} |       # cannot contain any operator three or more times consecutively
      [\+\-][\*\/]          # any addition or subtraction operator cannot followed by a
                            # multiplication or division operator
  /x

  class Input
    attr_reader :content

    def initialize(content = "")
      @content = normalize(content)
      check_validity unless content.empty?
    end

    def content= content
      initialize(content)
    end

    private

    def normalize(content)
      content.delete(' ')
    end

    def check_validity
      raise InvalidContentError if @content.match(INPUT_INVALID_REGEXP)
    end
  end

  class InvalidContentError < StandardError
    def message
      "Your input is invalid for calculation!"
    end
  end
end
