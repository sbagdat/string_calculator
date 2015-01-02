module Calculable
  INPUT_INVALID_REGEXP = %r!
    ^([/\*]|[\+\-]{2}) | # starts with a * or / or multiple + or - operators
    [^0-9]$            | # ends with a char other than a number
    [^0-9\+\-\*/]      | # any invalid char
    [\*/]{2}           | # consecutive * or / operator
    [\+\-\*/]{3}       | # any operator three or more times consecutively
    [\+\-][\*/]          # any + or - operator followed by a * or /
  !x

  class Input
    attr_reader :content

    def initialize(content = '')
      @content = normalize(content)
      check_validity unless content.empty?
    end

    def content=(content)
      initialize(content)
    end

    private

    def normalize(content)
      content.delete(' ')
    end

    def check_validity
      fail InvalidContentError if @content.match(INPUT_INVALID_REGEXP)
    end
  end

  class InvalidContentError < StandardError
    def message
      'Content is invalid for calculation!'
    end
  end
end
