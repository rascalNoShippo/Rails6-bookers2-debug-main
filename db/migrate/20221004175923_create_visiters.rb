class CreateVisiters < ActiveRecord::Migration[6.1]
  def change
    create_table :visiters do |t|
      t.integer :visiter_id
      t.integer :book_id
      t.timestamps
    end
  end
end
