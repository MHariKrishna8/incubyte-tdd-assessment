class StringCalculator

  # {params} - String
  # {return} - Integer
  def self.add(string)
    return 0 if string.empty?
    number = string.strip.to_i
  end
end
