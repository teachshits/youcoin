class CreateCashes < ActiveRecord::Migration
  def change
    create_table :cashes, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.string :name
      t.references :user
      t.timestamps
    end
  end
end
