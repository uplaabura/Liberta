class AddReferenceCrewToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :crew, index: true, foreign_key: true
  end
end
