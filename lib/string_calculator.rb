class StringCalculator

  # {params} - String
  # {return} - Integer
  def self.add(string)
    validate_input(string)
    
    return 0 if string.strip.empty?
    
    numbers = parse_numbers(string)
    numbers.sum
  end

  private

  # {params} - String
  # {return} - Array
  def self.parse_numbers(string)
    delimiters = [",", "\n"]
    negatives, non_digits = [], []

    # Handle custom delimiters
    if string.start_with? "//"
      custom_delimiter_string, string_rest = string.split("\n", 2)
      raise ArgumentError, "Invalid input: missing digits string after delimiter declaration" if string_rest.nil?

      custom_delimiter = custom_delimiter_string.chars.last
      delimiters << custom_delimiter
      string = string_rest
    end

    pattern = Regexp.union(delimiters)
    numbers = string.strip.split(pattern).map do |number|
      number.strip!
      non_digits << number unless number =~ /\A-?\d+\z/ # Allow digits only

      negatives << number if number.to_i < 0
      number.to_i
    end

    # Handle non-digits
    raise ArgumentError, "Invalid input: (#{non_digits.join(', ')})" if non_digits.any?

    # Handle negative numbers
    raise ArgumentError, "negative numbers not allowed (#{negatives.join(', ')})" if negatives.any?

    numbers
  end

  # {params} - String
  # {return} - void
  def self.validate_input(string)
    raise ArgumentError, "Invalid input class: #{string.class}" if string.class != String
  end
end
