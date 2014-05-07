class AddMoreFieldsToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :detail_page, :string
    add_column :apartments, :address, :string
    add_column :apartments, :description, :text
  end
end
