class CreatePayfulWebhooks < ActiveRecord::Migration[4.2]
  def change
    create_table :payful_webhooks do |t|
      t.integer :hookable_id
      t.string :hookable_type
      t.string :state, null: false
      t.datetime :failed_at
      t.datetime :processed_at
      t.string :source
      t.string :source_reference_id
      t.string :event
      t.text :data_json

      t.timestamps null: false
    end
    add_index :payful_webhooks, :state
    add_index :payful_webhooks, :source_reference_id
    add_index :payful_webhooks, [:hookable_id, :hookable_type]
  end
end
