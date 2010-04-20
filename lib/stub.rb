class Stub

  def initialize
     @methods = {}
  end

  def when_receives(method_name)
    if(@methods.has_key?(method_name))
      @methods[method_name]
    else
      @methods[method_name] = StubMethod.new method_name
    end
  end

  def method_missing(symbol, *args)
    if (@methods.has_key?(symbol))
      return @methods[symbol].value(args)
    end
    super.method_missing(symbol, *args)
  end
end

class StubMethod

  def initialize name
    @name = name
    @param_value = {}
    @return_values = []
  end

  def with(value)
    @last_param = value
    self
  end

  def then_return(value)
    if(@last_param == nil)
      @return_values.push(value)
    else
      @param_value[@last_param] = value
    end

    self    
  end

  def value(argument = nil)
    if(not argument.empty?)
      if @param_value[argument[0]] == nil
        raise "No return value was set for method '#{@name}'."
      end
      @param_value[argument[0]]
    else
      raise "No return value was set for method '#{@name}'." if @return_values.empty?
      @return_values.delete_at(0)
    end

  end

end