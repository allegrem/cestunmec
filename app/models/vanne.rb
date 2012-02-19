class Vanne < ActiveRecord::Base
  belongs_to :membre
  has_many :lols
end
