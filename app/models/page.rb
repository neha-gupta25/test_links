class Page < ActiveRecord::Base

  validates :html,:name, presence: true

end
