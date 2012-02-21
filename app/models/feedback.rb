class Feedback < ActiveRecord::Base
  belongs_to :membre
  
  validates :email, :presence => true, :format => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
  validates :message, :presence => true
end
