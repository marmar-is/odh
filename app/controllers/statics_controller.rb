class StaticsController < ApplicationController
  skip_before_filter :authenticate_account!
  layout false

  def index
  end
end
