class CreateVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :visitors do |t|
      t.integer :visitor_id
      t.integer :book_id
      t.timestamps
    end
  end
end
