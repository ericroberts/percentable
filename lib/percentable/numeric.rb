module Percentable
  module Numeric
    def to_percent
      Percentable::Percent.new(self)
    end
  end
end

class Numeric
  include Percentable::Numeric
end
