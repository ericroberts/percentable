require 'spec_helper'
require 'percentable'
require 'bigdecimal'

describe Numeric do
  [1, 1.0, BigDecimal.new(1, 10)].each do |numeric|
    subject { numeric }

    context numeric.class.name do
      describe '#to_percent' do
        it 'should respond to it' do
          expect(subject).to respond_to :to_percent
        end

        it 'should return the value as percent' do
          expect(subject.to_percent).to eq Percentable::Percent.new(subject)
        end
      end
    end
  end
end
