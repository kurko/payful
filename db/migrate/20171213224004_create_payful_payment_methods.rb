class CreatePayfulPaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payful_payment_methods do |t|
      t.string :owner_id, null: false
      t.string :owner_type, null: false

      t.string :service, null: false
      t.string :method_type, null: false
      t.datetime :expires_at
      t.boolean :is_default, null: false

      t.string :details_json, default: '{}'

      t.timestamps null: false
    end

    add_index :payful_payment_methods, :is_default
    add_index :payful_payment_methods, [:owner_id, :owner_type]
  end
end
