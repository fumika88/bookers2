class Book < ApplicationRecord
  belongs_to :user
  attachment :profile_image # ここを追加（_idは含めません）

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200 }
end
