# spec/string_calculator_spec.rb
require_relative "../lib/string_calculator"

RSpec.describe StringCalculator do
  describe '#add' do
    context 'empty string' do
      it 'returns 0 for empty string' do
        expect(StringCalculator.add("")).to eq(0)
      end
    end

    context 'single digit string' do
      it 'returns that only number' do
        expect(StringCalculator.add("1")).to eq(1)
      end
    end

    context 'multiple digit string' do
      it 'returns the sum of the digits' do
        expect(StringCalculator.add("1, 2")).to eq(3) 
      end

      it 'returns the sum of the digits with new lines' do
        expect(StringCalculator.add("1\n2")).to eq(3)
      end

      it 'returns the sum of the digits with custom delimiters' do
        expect(StringCalculator.add("//;\n1;2")).to eq(3)
      end

      it 'raises an exception if the digits are negative' do
        expect { StringCalculator.add("-1, 2") }.to raise_error(ArgumentError)
      end

      it 'raises an exception if the digits are not negative with custom delimiters' do
        expect { StringCalculator.add("//;\n-1;2") }.to raise_error(ArgumentError)
      end

      it 'raises a single exception if multiple negative digits are provided' do
        expect { StringCalculator.add("-1, -2") }.to raise_error(ArgumentError, "negative numbers not allowed (-1, -2)")
      end
    end

    context 'edge cases' do
      it 'raises an exception if the string is nil' do
        expect { StringCalculator.add(nil) }.to raise_error(ArgumentError, 'Invalid input class: NilClass')
      end

      it 'raises an exception if the input type is not string' do
        expect { StringCalculator.add(1) }.to raise_error(ArgumentError, 'Invalid input class: Integer')
      end

      it 'raises an exception if the invalid integer types are present in the string' do
        expect { StringCalculator.add("1, a") }.to raise_error(ArgumentError, 'Invalid input: (a)')
      end

      it 'raises an exception if multiple invalid integer types are present in the string' do
        expect { StringCalculator.add("1, a, b") }.to raise_error(ArgumentError, 'Invalid input: (a, b)')
      end

      # We can also have combination of test cases like 
      # - single negative digits with custom delimiters
      # - multiple negative digits with custom delimiters
      # - multiple negative digits with multiple custom delimiters and so on. For time being we are ignoring this
    end
  end
end
