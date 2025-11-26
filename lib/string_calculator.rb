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
    string.strip.split(',').map(&:to_i)
  end
end
