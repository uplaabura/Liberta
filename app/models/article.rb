class Article < ActiveRecord::Base
  belongs_to :crew
	has_many :comments, dependent: :destroy
	#validates :title, 	presence: true, length: { minimum: 5 }
end
