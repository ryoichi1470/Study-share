class Group < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :theme, presence: true
end
