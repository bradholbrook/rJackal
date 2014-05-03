class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string   :name
      t.string   :city
      t.string   :state
      t.string   :zip
      t.string   :phone
      t.string   :max_bedrooms
      t.string   :min_bedrooms
      t.string   :min_price
      t.string   :max_price
      t.string   :image_tag
      t.string   :image
      t.timestamps
    end
  end
end