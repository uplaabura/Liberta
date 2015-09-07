class AddColumnsToCrews < ActiveRecord::Migration
  def change
    add_column :crews, :provider, :string
    add_column :crews, :uid, :string
 
  end
end
