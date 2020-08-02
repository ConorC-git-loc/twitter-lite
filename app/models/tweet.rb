class Tweet < ApplicationRecord
	belongs_to :user, optional: true
	has_many :likes, dependent: :destroy

	validates :content, presence: true

end
