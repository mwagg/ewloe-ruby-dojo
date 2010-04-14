class Stub

  def initialize
     @methods = {}
  end

  def when_receives(method_name)
     @methods[method_name] = StubMethod.new method_name
  end

  def method_missing(symbol, *args)
    if (@methods.has_key?(symbol))
      return @methods[symbol].value
    end
    super.method_missing(symbol, *args)
  end
end

class StubMethod
  def initialize name
    @name = name
  end

  def then_return(value)
    @value = value
  end

  def value
    raise "No return value was set for method '#{@name}'." if @value == nil
    @value
  end
end