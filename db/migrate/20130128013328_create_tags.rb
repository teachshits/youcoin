class CreateTags < ActiveRecord::Migration

  def change
    create_table :tags, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.strung :name, :null => false
      t.references :user

      t.timestamps
    end
  end

end
