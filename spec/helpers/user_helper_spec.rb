require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe UserHelper do
	describe "sensible error" do
		let(:err_dup) { ["can't be blank","can't be blank"] }
		let(:err_redun) { ["can't be blank","can't be blank", "invalid"] }
		it "renders the field error partial" do
			expect(sensible_error(err_dup, 'label')).to render_template('users/_field_error')
		end

		describe "calls error_message_sanitize" do

			it "removes duplicate errors" do
				expect(error_message_sanitize(err_dup)).to eq(["can't be blank"])
			end
			it "removes logically redundant validation errors" do
				expect(error_message_sanitize(err_redun)).to eq(["can't be blank"])
			end
		end
	end
end
