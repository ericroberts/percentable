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

    def + other
      case other
      when Percent
        self.class.new(other.value + value)
      when Numeric
        self.class.new(other*100 + value)
      end
    end

    def * other
      case other
      when Percent
        self.class.new(other.value * value)
      when Numeric
        self.class.new(other * value)
      end
    end
  end
end
