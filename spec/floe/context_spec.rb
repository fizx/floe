require "rspec"
require File.expand_path(File.join(File.dirname(__FILE__), "../../lib/floe"))
include Floe
include FileUtils
describe "Floe::Context" do
  before do
    @ctxt = Context.new :dir => ".", :remote => "origin"
  end
  
  context "uninitialized" do
    before do
      rm_f ".floe"
    end
    it "should recognize the git remote" do
      @ctxt.repo.should be_a(Grit::Repo)
      @ctxt.repo_name.should == "floe"
      @ctxt.user.should == "fizx"
    end
  
    it "should not be initialized" do
      @ctxt = Context.new :dir => ".", :remote => "origin"
      @ctxt.should_not be_initialized
    end
    
    it "should be able to init" do
      @ctxt.init!
      @ctxt.should be_initialized
    end

    it "should not be able set milestone" do
      proc { @ctxt.set_current_milestone("oops") }.should raise_error
    end
  end
  
  context "initialized" do
    before do
      rm_f ".floe"
      @ctxt.init!
    end
    
    it "should be able to status" do
      @ctxt.status.should == {
        "milestone" => nil,
        "issue" => nil
      }
    end
    
    it "should be able to set and persist milestone" do
      @ctxt.set :milestone, 7
      @ctxt = Context.new :dir => ".", :remote => "origin"
      @ctxt.should be_initialized
      @ctxt.status.should == {
        "milestone" => 7,
        "issue" => nil
      }
    end
  end
  
end