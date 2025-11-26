# lib/string_calculator.rb
class StringCalculator

  # {params} - String
  # {return} - Integer
  def self.add(input)
    validate!(input)
    
    return 0 if input.strip.empty?
    
    numbers = parse_numbers(input)
    numbers.sum
  end

  private

  # {params} - String
  # {return} - Array
  def self.parse_numbers(string)
    delimiters = [",", "\n"]

    # Handle custom delimiters
    if string.start_with? "//"
      custom_delimiter_string, string_rest = string.split("\n", 2)
      raise ArgumentError, "Invalid input: missing digits string after delimiter declaration" if string_rest.nil?

      custom_delimiter = custom_delimiter_string.chars.last
      delimiters << custom_delimiter
      string = string_rest
    end

    # Construct regex pattern
    pattern = Regexp.union(delimiters)

    negatives, non_digits = [], []
    numbers = string.strip.split(pattern).map do |val|
      val.to_s.strip!
      next nil if val.empty? # Ignore empty strings that might come in trailing commas

      # Allow digits only
      unless val =~ /\A-?\d+\z/
        non_digits << val  
        next nil
      end

      number = val.to_i
      negatives << number if number < 0
      number
    end.compact

    # Handle non-digits
    raise ArgumentError, "Invalid input: (#{non_digits.join(', ')})" if non_digits.any?

    # Handle negative numbers
    raise ArgumentError, "negative numbers not allowed (#{negatives.join(', ')})" if negatives.any?

    numbers
  end

  # {params} - String
  # {return} - void
  def self.validate!(input)
    unless input.is_a?(String)
      raise ArgumentError, "Invalid input class: #{input.class}"
    end
  end
end
