class Follower < ApplicationRecord
  belongs_to :user, foreign_key: :following_id, primary_key: :id
  belongs_to :user, foreign_key: :follower_id, primary_key: :id
end
