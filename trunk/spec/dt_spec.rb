require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Dt" do

  before :all do
    @browser = Browser.new
  end

  before :each do
    @browser.goto(TEST_HOST + "/definition_lists.html")
  end


  # Exists method
  describe "#exists?" do
    it "should return true if the element exists" do
      @browser.dt(:id, "experience").should exist
      @browser.dt(:class, "current-industry").should exist
      @browser.dt(:xpath, "//dt[@id='experience']").should exist
      @browser.dt(:index, 1).should exist
    end

    it "should return false if the element does not exist" do
      @browser.dt(:id, "no_such_id").should_not exist
    end

    it "should raise TypeError when 'what' argument is invalid" do
      lambda { @browser.dt(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "should raise MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.dt(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods
  describe "#class_name" do
    it "should return the class attribute if the element exists" do
      @browser.dt(:id , "experience").class_name.should == "industry"
    end

    it "should return an empty string if the element exists but the attribute doesn't" do
      @browser.dt(:id , "education").class_name.should == ""
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda { @browser.dt(:id, "no_such_id").class_name }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:title, "no_such_title").class_name }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:index, 1337).class_name }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:xpath, "//dt[@id='no_such_id']").class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "should return the id attribute if the element exists" do
      @browser.dt(:class, 'industry').id.should == "experience"
    end

    it "should return an empty string if the element exists, but the attribute doesn't" do
      @browser.dt(:class, 'current-industry').id.should == ""
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda {@browser.dt(:id, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda {@browser.dt(:title, "no_such_id").id }.should raise_error(UnknownObjectException)
      lambda {@browser.dt(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "should return the title of the element" do
      @browser.dt(:id, "experience").title.should == "experience"
    end
  end

  describe "#text" do
    it "should return the text of the element" do
      @browser.dt(:id, "experience").text.should == "Experience"
    end

    it "should return an empty string if the element exists but contains no text" do
      @browser.dt(:class, 'noop').text.should == ""
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda { @browser.dt(:id, "no_such_id").text }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:title, "no_such_title").text }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:index, 1337).text }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:xpath, "//dt[@id='no_such_id']").text }.should raise_error(UnknownObjectException)
    end
  end

  describe "#respond_to?" do
    it "should return true for all attribute methods" do
      @browser.dt(:index, 1).should respond_to(:id)
      @browser.dt(:index, 1).should respond_to(:class_name)
      @browser.dt(:index, 1).should respond_to(:style)
      @browser.dt(:index, 1).should respond_to(:text)
      @browser.dt(:index, 1).should respond_to(:title)
    end
  end

  # Manipulation methods
  describe "#click" do
    it "should fire events when clicked" do
      @browser.dt(:id, 'education').text.should_not == 'changed'
      @browser.dt(:id, 'education').click
      @browser.dt(:id, 'education').text.should == 'changed'
    end

    it "should raise UnknownObjectException if the element does not exist" do
      lambda { @browser.dt(:id, "no_such_id").click }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:title, "no_such_title").click }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:index, 1337).click }.should raise_error(UnknownObjectException)
      lambda { @browser.dt(:xpath, "//dt[@id='no_such_id']").click }.should raise_error(UnknownObjectException)
    end
  end

  describe "#html" do
    it "should return the HTML of the element" do
      html = @browser.dt(:id, 'name').html
      html.should match(%r"<div>.*Name.*</div>"m)
      html.should_not include('</body>')
    end
  end

  describe "#to_s" do
    it "should return a human readable representation of the element" do
      @browser.dt(:id, 'experience').to_s.should ==
%q{tag:          dt
  id:           experience
  class:        industry
  title:        experience
  text:         Experience}
    end
  end

  after :all do
    @browser.close
  end

end

