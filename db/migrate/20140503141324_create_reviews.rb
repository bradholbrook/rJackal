class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :apartment
      t.text   :body
      t.timestamps
    end
    
    add_index :reviews, [:apartment_id, :created_at], unique: true

  end
end