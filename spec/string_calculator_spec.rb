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
  end
end
