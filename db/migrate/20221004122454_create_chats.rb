class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :body
      t.timestamps
    end
  end
end
