module Percentable
  class Percent < ::Numeric
    def initialize(value)
      if value.is_a? Percent
        @value = value.value
      else
        @value = value.to_f
      end
    end

    def value
      @value ||= 0.to_f
    end

    def to_s
      '%g%%' % value
    end

    def format formatter = '%g%%'
      formatter % value
    end

    def to_f
      value/100
    end

    def to_i
      value.to_i
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
      if other.is_a? Percent
        self.class.new(to_f * other.value)
      elsif other.respond_to? :coerce
        a, b = other.coerce(self)
        a * b
      else
        raise TypeError, "#{other.class} can't be coerced into Percent"
      end
    end

    [:+, :-, :/].each do |operator|
      define_method operator do |other|
        case other
        when Percent
          self.class.new(value.public_send(operator, other.value))
        else
          self.class.new(value.public_send(operator, other.to_f))
        end
      end
    end

    def to_percent
      self
    end

    def self.from_numeric(numeric)
      case numeric
      when Numeric
        Percent.new(numeric*100)
      else
        fail TypeError, 'must inherit from Numeric'
      end
    end

    def coerce other
      [CoercedPercent.new(self), other]
    end
  end
end

Percent = Percentable::Percent
