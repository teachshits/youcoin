class PaymentsTags < ActiveRecord::Migration
    def change
	create_table :payments_tags do |t|
	    t.string :tag_id
	    t.string :payment_id
	end
	
	add_index :payments_tags, [:tag_id, :payment_id]
    end
end
