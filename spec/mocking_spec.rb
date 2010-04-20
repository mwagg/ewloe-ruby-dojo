require "spec/spec_helper"

describe "Stub" do

  it "should return the expected value when stubbed" do
    stub = Stub.new

    stub.when_receives(:hello_world).then_return('No go away')
    
    stub.hello_world.should == 'No go away'
  end

  it "should be able to stub multiple methods" do
    stub = Stub.new

    stub.when_receives(:one).then_return(1)
    stub.when_receives(:two).then_return(2)

    stub.one.should == 1
    stub.two.should == 2
  end

  it "should return an error if no return value is specified" do
    stub = Stub.new

    stub.when_receives(:one)
    stub.when_receives(:two).then_return(2)

    lambda{ stub.one }.should raise_error "No return value was set for method 'one'."
  end

  it "should handle a really evil test from mike" do
    stub = Stub.new
      
    one = stub.when_receives(:one)
    stub.when_receives(:two).then_return(2)

    one.then_return(1)

    stub.one.should == 1
  end


  it "should be able to return different values on each execution" do
    stub = Stub.new

    stub.when_receives(:one).then_return(3).then_return(4).then_return(5);

    stub.one().should == 3
    stub.one().should == 4
    stub.one().should == 5
  end
end