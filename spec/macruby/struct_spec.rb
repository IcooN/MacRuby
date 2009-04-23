require File.dirname(__FILE__) + '/../spec_helper'

framework 'Foundation'

describe "A BridgeSupport structure" do
  it "is an instance of Boxed" do
    NSPoint.superclass.should == Boxed
    NSSize.superclass.should == Boxed
    NSRect.superclass.should == Boxed
    NSRange.superclass.should == Boxed
  end

  it "can be created with null values using the #new method with no argument" do
    o = NSPoint.new
    o.x.class.should == Float
    o.y.class.should == Float
    o.x.should == 0.0
    o.y.should == 0.0

    o = NSRect.new
    o.origin.class.should == NSPoint
    o.origin.x.class.should == Float
    o.origin.y.class.should == Float
    o.origin.x.should == 0.0
    o.origin.y.should == 0.0
    o.size.class.should == NSSize
    o.size.width.class.should == Float
    o.size.height.class.should == Float
    o.size.width.should == 0.0
    o.size.height.should == 0.0
  end

  it "can be created with given values using the #new method with arguments" do
    o = NSPoint.new(1.0, 2.0)
    o.y.class.should == Float
    o.x.class.should == Float
    o.x.should == 1.0
    o.y.should == 2.0

    o = NSPoint.new(1, 2)
    o.x.class.should == Float
    o.y.class.should == Float
    o.x.should == 1.0
    o.y.should == 2.0

    fix1 = Object.new; def fix1.to_f; 1.0; end
    fix2 = Object.new; def fix2.to_f; 2.0; end

    o = NSPoint.new(fix1, fix2)
    o.x.class.should == Float
    o.y.class.should == Float
    o.x.should == 1.0
    o.y.should == 2.0

    lambda { NSPoint.new(1) }.should raise_error(ArgumentError) 
    lambda { NSPoint.new(1, 2, 3) }.should raise_error(ArgumentError)
    lambda { NSPoint.new(Object.new, 42) }.should raise_error(TypeError)
    lambda { NSPoint.new(nil, nil) }.should raise_error(TypeError)

    o = NSRect.new(NSPoint.new(1, 2), NSSize.new(3, 4))
    o.origin.class.should == NSPoint
    o.origin.x.class.should == Float
    o.origin.y.class.should == Float
    o.origin.x == 1.0
    o.origin.y == 2.0
    o.size.class.should == NSSize
    o.size.width.class.should == Float
    o.size.height.class.should == Float
    o.size.width == 3.0
    o.size.height == 4.0

    lambda { NSRect.new(1) }.should raise_error(ArgumentError)
    lambda { NSRect.new(1, 2) }.should raise_error(TypeError)
    lambda { NSRect.new(1, 2, 3) }.should raise_error(ArgumentError)
    lambda { NSRect.new(1, 2, 3, 4) }.should raise_error(ArgumentError)
    lambda { NSRect.new(NSSize.new, NSPoint.new) }.should raise_error(TypeError)
    lambda { NSRect.new(nil, nil) }.should raise_error(TypeError)
  end

  it "has accessors for every field" do
    p = NSPoint.new
    p.x = 1
    p.y = 2
    p.x.class.should == Float
    p.y.class.should == Float
    p.x.should == 1.0
    p.y.should == 2.0

    s = NSSize.new
    s.width = 3
    s.height = 4
    s.width.class.should == Float
    s.height.class.should == Float
    s.width.should == 3.0
    s.height.should == 4.0

    r = NSRect.new
    r.origin = p
    r.size = s
    r.origin.class.should == NSPoint
    r.size.class.should == NSSize

    lambda { r.origin = nil }.should raise_error(TypeError)
    lambda { r.origin = Object.new }.should raise_error(TypeError)

    r.origin = [123, 456]
    r.size = [789, 100]
    
    r.origin.x.class.should == Float
    r.origin.y.class.should == Float
    r.size.width.class.should == Float
    r.size.height.class.should == Float
    r.origin.x.should == 123.0
    r.origin.y.should == 456.0
    r.size.width.should == 789.0
    r.size.height.should == 100.0
  end
end
