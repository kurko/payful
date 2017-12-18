class CreatePayfulPaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payful_payment_methods, id: :uuid do |t|
      t.string :owner_id
      t.string :owner_type

      t.string :service
      t.string :method_type
      t.jsonb :details, default: '{}'

      t.timestamps
    end

    add_index :payful_payment_methods, [:owner_id, :owner_type]
  end
end
