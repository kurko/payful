class CreatePayfulMemberships < ActiveRecord::Migration
  def change
    create_table :payful_memberships do |t|
      t.references :payful_service, index: true, foreign_key: true
      t.integer  :memberable_id
      t.string   :memberable_type
      t.boolean  :active
      t.integer  :base_price_in_cents
      t.integer  :base_price_days
      t.datetime :expires_at

      t.timestamps null: false
    end
    add_index :payful_memberships, [:memberable_id, :memberable_type]
    add_index :payful_memberships, :active
  end
end
