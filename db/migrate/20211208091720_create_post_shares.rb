class CreatePostShares < ActiveRecord::Migration[6.1]
  def change
    create_table :post_shares do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
