require 'spec_helper'
require 'percentable/percent'
require 'percentable/percentize'

class TestClass
  def returns_a_percent
    10
  end
end

class Subject < TestClass
  extend Percentable::Percentize

  percentize :returns_a_percent
end

describe Percentable::Percentize do
  subject { Subject.new }

  it 'should return a percent with value of TestClass' do
    expect(subject.returns_a_percent).to eq Percentable::Percent.new(10)
  end
end
