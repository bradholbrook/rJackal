class AddFieldsToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :city, :string
    add_column :apartments, :state, :string
    add_column :apartments, :zip, :string
    add_column :apartments, :phone, :string
    add_column :apartments, :max_bedrooms, :string
    add_column :apartments, :min_bedrooms, :string
    add_column :apartments, :max_price, :string
    add_column :apartments, :min_price, :string
    add_column :apartments, :image_tag, :string
    add_column :apartments, :image, :string
  end
end
