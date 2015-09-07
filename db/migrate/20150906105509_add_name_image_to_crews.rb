class AddNameImageToCrews < ActiveRecord::Migration
  def change
    add_column :crews, :name, :string
    add_column :crews, :image, :string
  end
end
