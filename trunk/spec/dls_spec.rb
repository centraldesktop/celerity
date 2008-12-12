require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Dls" do
  before :all do
    @browser = Browser.new
  end

  before :each do
    @browser.goto(TEST_HOST + "/definition_lists.html")
  end

  describe "#length" do
    it "should return the number of dls" do
      @browser.dls.length.should == 3
    end
  end

  describe "#[]" do
    it "should return the dl at the given index" do
      @browser.dls[1].id.should == "experience-list"
    end
  end

  describe "#each" do
    it "should iterate through dls correctly" do
      @browser.dls.each_with_index do |d, index|
        d.name.should == @browser.dl(:index, index+1).name
        d.id.should == @browser.dl(:index, index+1).id
        d.class_name.should == @browser.dl(:index, index+1).class_name
      end
    end
  end

  after :all do
    @browser.close
  end

end

