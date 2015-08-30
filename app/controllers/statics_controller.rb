class StaticsController < ApplicationController
  skip_before_filter :authenticate_account!

  def index
  end
end
