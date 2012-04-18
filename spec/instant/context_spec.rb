require 'spec_helper'
require 'pp'

describe Instant::Context do
  it "should log assignment" do
    subject.log_assign(:a, "10")
    subject.to_s.strip.should == "a = 10"
  end
  
  it "should log assignment inside loop" do
    subject.loop_begin

    subject.loop_inside_begin
    subject.log_assign(:a, "10")
    subject.loop_inside_end

    subject.loop_inside_begin
    subject.log_assign(:a, "11")
    subject.loop_inside_end

    subject.loop_inside_begin
    subject.log_assign(:a, "12")
    subject.loop_inside_end

    subject.loop_end

    subject.to_s.strip.should == "a =  10  | 11  | 12"
  end

  it "should log multiple assignment inside loop" do
    subject.loop_begin

    subject.loop_inside_begin
    subject.log_assign(:a, "10")
    subject.log_assign(:b, "A")
    subject.loop_inside_end

    subject.loop_inside_begin
    subject.log_assign(:a, "11")
    subject.loop_inside_end

    subject.loop_inside_begin
    subject.log_assign(:a, "12")
    subject.log_assign(:b, "C")
    subject.loop_inside_end

    subject.loop_end

    outputs = subject.to_s.split("\n").collect{|l| l.strip}    
    outputs.should be_include("a =  10  | 11  | 12")
    outputs.should be_include("b =   A  |     |  C")
  end
end
