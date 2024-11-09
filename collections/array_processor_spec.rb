require 'rspec'
require './array_processor'

RSpec.describe ArrayProcessor do
  let(:arr_proc) { ArrayProcessor.new([1, 2, 3, 4, 5]) }
  
  describe '#all?' do
    it 'returns true if all elements meet the condition' do
      expect(arr_proc.all? { |el| el > 0 }).to eq(true)
    end
  end

  describe '#flat_map' do
    it 'maps and flattens the array based on the given block' do
      expect(arr_proc.flat_map { |el| [el, el * 2] }).to eq([1, 2, 2, 4, 3, 6, 4, 8, 5, 10])
    end
  end

  describe '#one?' do
    it 'returns true if exactly one element meets the condition' do
      expect(arr_proc.one? { |el| el == 3 }).to eq(true)
    end
  end

  describe '#inject' do
    it 'accumulates values based on the given block' do
      expect(arr_proc.inject(0) { |sum, el| sum + el }).to eq(15)
    end
  end

  describe '#min_by' do
    it 'returns the element with the minimum value based on the given block' do
      expect(arr_proc.min_by { |el| -el }).to eq(5)
    end
  end

  describe '#find' do
    it 'returns the first element that meets the condition' do
      expect(arr_proc.find { |el| el > 3 }).to eq(4)
    end
  end
end
