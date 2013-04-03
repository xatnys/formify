require 'spec_helper'

describe "Statics" do
  describe "GET /" do
    it "shows static#home" do
 			get(root_path).should render_template('static/home')
    end
  end
end
