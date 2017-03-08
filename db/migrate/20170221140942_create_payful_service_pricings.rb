class CreatePayfulServicePricings < ActiveRecord::Migration
  def change
    create_table :payful_service_pricings do |t|
      t.integer :service_id, index: true
      t.integer :period_in_days
      t.integer :amount_in_cents

      t.timestamps null: false
    end


    add_foreign_key :payful_service_pricings, :payful_services, column: :service_id, primary_key: :id
  end
end
