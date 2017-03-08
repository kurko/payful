class CreatePayfulServices < ActiveRecord::Migration
  def change
    create_table :payful_services do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
