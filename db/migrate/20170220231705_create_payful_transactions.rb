class CreatePayfulTransactions < ActiveRecord::Migration[4.2]
  def change
    create_table :payful_transactions do |t|
      t.integer  :owner_id
      t.string   :owner_type
      t.string   :state, null: false
      t.datetime :completed_at
      t.integer  :extends_memberships_for_days
      t.text     :metadata_json, default: "{}"
      t.integer  :amount_in_cents, null: false
      t.string   :payment_type
      t.string   :payment_url
      t.string   :payment_remote_id
      t.datetime :payment_emailed_at

      t.timestamps null: false
    end

    add_index :payful_transactions, :state
    add_index :payful_transactions, :payment_remote_id
    add_index :payful_transactions, [:owner_type, :owner_id], name: 'payful_txn_owner_type_id'

    create_table :payful_memberships_transactions, id: false do |t|
      t.integer :membership_id, index: true, null: false
      t.integer :transaction_id, index: true, null: false
    end
  end
end
