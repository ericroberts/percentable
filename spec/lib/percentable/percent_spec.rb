require 'spec_helper'
require 'percentable/percent'

describe Percentable::Percent do
  subject { Percentable::Percent.new(value) }
  let(:value) { nil }

  describe '#initialize' do
    context 'with value represented as string' do
      let(:value) { '50%' }

      it 'should have a value of 50' do
        expect(subject.value).to eq 50
      end
    end
  end

  describe '#to_s' do
    context 'with value of 50' do
      let(:value) { 50 }

      it 'should return 50%' do
        expect(subject.to_s).to eq '50%'
      end
    end

    context 'with value of 0.025' do
      let(:value) { 0.025 }

      it 'should return 0.025%' do
        expect(subject.to_s).to eq '0.025%'
      end
    end
  end

  describe '#to_f' do
    context 'with value of 50' do
      let(:value) { 50 }

      it 'should return 0.5' do
        expect(subject.to_f).to eq 0.5
      end
    end

    context 'with value of 10.5' do
      let(:value) { 10.5 }

      it 'should return 0.105' do
        expect(subject.to_f).to eq 0.105
      end
    end
  end

  describe '#zero?' do
    context 'with value of 0' do
      let(:value) { 0 }

      it 'should return true' do
        expect(subject.zero?).to be true
      end
    end

    context 'with any other value' do
      let(:value) { 10 }

      it 'should return false' do
        expect(subject.zero?).to be false
      end
    end
  end

  shared_examples 'it is equal' do |equal_method|
    it 'should consider itself equal to other percents with the same value' do
      percent1 = subject.class.new(50)
      percent2 = subject.class.new(50)

      expect(percent1.send(equal_method, percent2)).to be true
    end

    it 'should consider itself equal to a float matching the float value' do
      float = 0.015
      percent = subject.class.new(float*100)

      expect(percent.send(equal_method, float)).to be true
    end

    it 'should consider itself equal to an integer matching the float value' do
      integer = 2
      percent = subject.class.new(integer*100)

      expect(percent.send(equal_method, integer)).to be true
    end
  end

  describe '#==' do
    it_should_behave_like 'it is equal', :==
  end

  describe '#eql?' do
    it_should_behave_like 'it is equal', :eql?
  end

  describe '#+' do
    context 'adding percents' do
      let(:percent1) { subject.class.new(50) }
      let(:percent2) { subject.class.new(50) }

      it 'should return the sum of both percents' do
        expect(percent1 + percent2).to eq subject.class.new(100)
      end
    end

    context 'adding integers' do
      let(:integer) { 1 }
      let(:percent) { subject.class.new(50) }

      it 'should return the sum of percent and integer' do
        expect(percent + integer).to eq subject.class.new(51)
      end
    end

    context 'adding floats' do
      let(:float) { 1.0 }
      let(:percent) { subject.class.new(25) }

      it 'should return the sum of percent and float' do
        expect(percent + float).to eq subject.class.new(26)
      end
    end
  end

  describe '#-' do
    context 'subtracting percents' do
      let(:percent1) { subject.class.new(50) }
      let(:percent2) { subject.class.new(10) }

      it 'should return the result after subtraction' do
        expect(percent1 - percent2).to eq subject.class.new(40)
      end
    end

    context 'subtracting other numerics' do
      let(:value) { 20 }

      [1, 1.0, BigDecimal.new(1.0, 10)].each do |numeric|
        context numeric.class.name do
          it "should return the result after subtracting the #{numeric.class.name} from the percent" do
            expect(subject - numeric).to eq subject.class.new(19)
          end
        end
      end
    end
  end

  describe '#*' do
    context 'multiplying percents' do
      let(:percent1) { subject.class.new(10) }
      let(:percent2) { subject.class.new(10) }

      it 'should return the result of multiplying the percents' do
        expect(percent1 * percent2).to eq subject.class.new(1)
      end
    end

    context 'multiplying other numerics' do
      let(:numeric) { 2 }
      let(:percent) { subject.class.new(20) }

      it 'should return the result of multipling the percent by the number' do
        expect(percent * numeric).to eq subject.class.new(40)
      end
    end
  end

  describe '#/' do
    context 'dividing percents' do
      let(:percent1) { subject.class.new(50) }
      let(:percent2) { subject.class.new(10) }

      it 'should return the result after division' do
        expect(percent1 / percent2).to eq subject.class.new(5)
      end
    end

    context 'dividing other numerics' do
      let(:value) { 20 }

      [5, 5.0, BigDecimal.new(5.0, 10)].each do |numeric|
        context numeric.class.name do
          it "should return the result after subtracting the #{numeric.class.name} from the percent" do
            expect(subject / numeric).to eq subject.class.new(4)
          end
        end
      end
    end
  end

  describe 'comparable' do
    it 'is comparable' do
      expect(Comparable === subject).to be true
    end

    context 'compared to other percents' do
      let(:larger_percent) { subject.class.new(100) }
      let(:smaller_percent) { subject.class.new(50) }

      it 'should be able to tell when things are larger' do
        expect(larger_percent > smaller_percent).to be true
      end

      it 'should be able to tell when things are smaller' do
        expect(smaller_percent < larger_percent).to be true
      end
    end

    context 'compared to integers' do
      context 'when integer is larger' do
        let(:integer) { 30 }
        let(:percent) { subject.class.new(10) }

        it 'should say the percent is smaller' do
          expect(percent < integer).to be true
        end
      end

      context 'when integer is smaller' do
        let(:integer) { 1 }
        let(:percent) { subject.class.new(101) }

        it 'should say the percent is larger' do
          expect(percent > integer).to be true
        end
      end
    end
  end
end
