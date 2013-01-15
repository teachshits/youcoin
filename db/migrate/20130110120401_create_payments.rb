class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments, :id => false do |t|
      t.decimal :summa, :null => false
      t.string :uuid, :limit => 36, :primary => true
      t.references :category
      t.references :cash

      t.timestamps
    end
  end
end
