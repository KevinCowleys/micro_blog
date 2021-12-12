class Block < ApplicationRecord
  belongs_to :user, foreign_key: :id, primary_key: :blocked_id
  belongs_to :user, foreign_key: :id, primary_key: :blocked_by_id
end
