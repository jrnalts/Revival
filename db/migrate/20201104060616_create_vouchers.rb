class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.string :name
      t.integer :uniform
      t.integer :tel
      t.references :user, null: false, foreign_key: true
      t.integer :serial

      t.timestamps
    end
  end
end
