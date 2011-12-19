require File.expand_path("../watirspec/spec_helper", __FILE__)

describe "Browser" do

  describe "#credentials=" do
    it "sets the basic authentication credentials" do
      p :status_code_exceptions => browser.status_code_exceptions

      browser.goto(WatirSpec.host + "/authentication")

      browser.text.should_not include("ok")
      browser.credentials = "foo:bar"

      browser.goto(WatirSpec.host + "/authentication")
      browser.text.should include("ok")
    end
  end
end
