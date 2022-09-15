class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :commenter_id
      t.integer :book_id
      t.text :comment_body
      t.timestamps
    end
  end
end
