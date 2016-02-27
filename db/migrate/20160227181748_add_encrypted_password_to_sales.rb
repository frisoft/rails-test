class AddEncryptedPasswordToSales < ActiveRecord::Migration
  def change
    add_column :sales, :encrypted_password, :string
  end
end
