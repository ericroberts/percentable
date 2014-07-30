module Percentable
  module Percentize
    def percentize *args
      options = args.pop if args.last.is_a? Hash

      args.each do |method_name|
        define_method(method_name) do |args=[]|
          Percent.new(super(*args) || options[:default])
        end
      end
    end
  end
end
