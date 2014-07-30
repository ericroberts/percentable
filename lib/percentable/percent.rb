module Percentable
  class Percent < ::Numeric
    def initialize(value)
      @value = value.to_f
    end

    def value
      @value ||= 0.to_f
    end

    def to_s
      '%g%%' % value
    end

    def to_f
      value/100
    end

    def to_i
      value.to_i
    end

    def coerce other
      case other
      when Numeric
        [to_f, other]
      else
        fail TypeError, "#{self.class} can't be coerced into #{other.class}"
      end
    end

    def == other
      (other.class == self.class && other.value == self.value) || other == self.to_f
    end

    def eql? other
      self.send(:==, other)
    end

    def <=> other
      to_f <=> other.to_f
    end

    def * other
      case other
      when Percent
        self.class.new(to_f * other.value)
      when Numeric
        self.class.new(value * other)
      end
    end

    [:+, :-, :/].each do |operator|
      define_method operator do |other|
        case other
        when Percent
          self.class.new(value.public_send(operator, other.value))
        when Numeric
          self.class.new(value.public_send(operator, other))
        end
      end
    end

    def self.from_numeric(numeric)
      case numeric
      when Numeric
        Percent.new(numeric*100)
      else
        fail TypeError, 'must inherit from Numeric'
      end
    end
  end
end

Percent = Percentable::Percent
