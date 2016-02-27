class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.date :dt
      t.time :tm
      t.string :code
      t.decimal :value, precision: 15, scale: 2
      t.timestamps
    end
  end
end
