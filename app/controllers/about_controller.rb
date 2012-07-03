class AboutController < ApplicationController
  skip_before_filter :require_login, :require_admin
  
  def index
    @titre = "A propos"
  end
end
