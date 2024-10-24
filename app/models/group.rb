class Group < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :group_memberships, dependent: :destroy
  has_many :members, through: :group_memberships, source: :user
  
  validates :name, presence: { message: "グループ名を入力してください" }, length: { minimum: 2, message: "グループ名は2文字以上である必要があります" }
  validates :theme, presence: { message: "テーマを入力してください" }
  validates :rules, presence: { message: "ルールを入力してください" }
  validates :creator, presence: true
end
