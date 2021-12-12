class Mute < ApplicationRecord
  belongs_to :user, foreign_key: :id, primary_key: :muted_id
  belongs_to :user, foreign_key: :id, primary_key: :muted_by_id
end
