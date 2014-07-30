require 'spec_helper'
require 'percentable'

class TestClass
  def returns_a_percent
    10
  end

  def first_percent_method
    15
  end

  def second_percent_method
    20
  end

  def default_percent_method
  end

  def default_filled_percent_method
    100
  end

  def default_percent_method1
  end

  def default_percent_method2
  end

  def default_percent_method3
    20.5
  end
end

class Subject < TestClass
  extend Percentable::Percentize

  percentize :returns_a_percent
  percentize :first_percent_method, :second_percent_method
  percentize :default_percent_method, default: 10
  percentize :default_filled_percent_method, default: 20
  percentize :default_percent_method1, :default_percent_method2, :default_percent_method3, default: 20
end

describe Percentable::Percentize do
  subject { Subject.new }
  let(:ancestor) { TestClass.new }

  [:returns_a_percent, :first_percent_method, :second_percent_method].each do |method|
    it 'should return a percent with value of TestClass' do
      expect(subject.public_send(method)).to eq Percentable::Percent.new(ancestor.send(method))
    end
  end

  context 'when passed a default value' do
    it 'should return the default value when return value is nil' do
      expect(subject.default_percent_method).to eq Percentable::Percent.new(10)
    end

    it 'should not return the default if the value is defined' do
      expect(subject.default_filled_percent_method).to eq Percentable::Percent.new(100)
    end

    context 'with multiple methods' do
      it 'should return the default value when return value is nil' do
        expect(subject.default_percent_method1).to eq Percentable::Percent.new(20)
      end

      it 'should return the default value when return value is nil' do
        expect(subject.default_percent_method2).to eq Percentable::Percent.new(20)
      end

      it 'should not return the default when the value is set' do
        expect(subject.default_percent_method3).to eq Percentable::Percent.new(20.5)
      end
    end
  end
end
