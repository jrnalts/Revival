class ChangeUniformAndTelToString < ActiveRecord::Migration[6.0]
  def change
    change_column :vouchers, :uniform, :string
    change_column :vouchers, :tel, :string
  end
end
