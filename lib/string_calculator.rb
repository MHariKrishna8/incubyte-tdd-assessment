class StringCalculator

  # {params} - String
  # {return} - Integer
  def self.add(string)
    return 0 if string.strip.empty?
    numbers = parse_numbers(string)
    numbers.sum
  end

  private

  def self.parse_numbers(string)
    delimiters = [",", "\n"]

    if string.start_with? "//"
      custom_delimiter_string, string_rest = string.split("\n", 2)
      raise ArgumentError, "Invalid input: missing digits string after delimiter declaration" if string_rest.nil?

      custom_delimiter = custom_delimiter_string.chars.last
      delimiters << custom_delimiter
      string = string_rest
    end

    pattern = Regexp.union(delimiters)
    string.strip.split(pattern).map do |number|
      raise ArgumentError, "negative numbers not allowed (#{number})" if number.to_i < 0
      number.to_i
    end
  end
end
