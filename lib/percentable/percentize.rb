module Percentable
  module Percentize
    def percentize field
      define_method(field) do |args=[]|
        Percent.new(super(*args))
      end
    end
  end
end
