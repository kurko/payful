class CreatePayfulCoupons < ActiveRecord::Migration
  def change
    create_table :payful_coupons do |t|
      t.integer  :owner_id
      t.string   :owner_type

      t.string :code, null: false
      t.string :description, null: true
      t.datetime :valid_from, null: false
      t.datetime :valid_until, null: true
      t.integer :redemption_limit, default: 1, null: false
      t.integer :coupon_redemptions_limit, default: 1
      t.integer :amount, null: false, default: 0
      t.string :coupon_type, null: false
      t.text :metadata_json

      t.timestamps null: false
    end

    add_index :payful_coupons, [:owner_id, :owner_type]

    create_table :payful_coupon_redemptions do |t|
      t.integer  :payful_coupon_id
      t.integer  :subject_id
      t.string   :subject_type
      t.timestamps null: false
    end
    add_index :payful_coupon_redemptions, [:payful_coupon_id]
    add_index :payful_coupon_redemptions, [:subject_id, :subject_type]
  end
end
