class Item < ApplicationRecord
	validates :user_id,{presence: true}
	belongs_to :user
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
