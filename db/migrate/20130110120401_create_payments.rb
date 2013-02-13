class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments, :id => false do |t|
      t.decimal :summa, :null => false, :precision => 11, :scale => 2
      t.integer :amount
      t.decimal	:price, :precision => 11, :scale => 2
      t.string :uuid, :limit => 36, :primary => true
      t.string :category_id, :null => false
      t.string :cash_id, :null => false
      t.text :description
      t.string :transfer_cash_id
      t.string :type

      t.timestamps
    end
    
    add_index :payments, :category_id
    add_index :payments, :cash_id
    add_index :payments, :transfer_cash_id
    
  end
end
