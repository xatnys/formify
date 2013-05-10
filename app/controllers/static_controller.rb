class StaticController < ApplicationController
  def home
  	@parent = Parent.new
  	@parent.phones.build
  	@parent.children.build
  end
end
