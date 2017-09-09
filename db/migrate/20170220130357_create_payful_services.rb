class CreatePayfulServices < ActiveRecord::Migration[4.2]
  def change
    create_table :payful_services do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
