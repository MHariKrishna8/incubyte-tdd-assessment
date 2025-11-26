class StringCalculator

  # {params} - String
  # {return} - Integer
  def self.add(string)
    return 0 if string.empty?
    numbers = string.strip.split(',').map(&:to_i)
    numbers.sum
  end
end
