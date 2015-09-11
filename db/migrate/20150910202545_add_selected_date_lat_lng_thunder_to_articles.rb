class AddSelectedDateLatLngThunderToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :lat, :float
    add_column :articles, :lng, :float 
    add_column :articles, :selected_date, :date  
    add_column :articles, :thunder, :integer
    
    add_reference :articles, :crew, index: true, foreign_key: true
  end
end
