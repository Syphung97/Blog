class AddRememberDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :remember_digest, :string
  end
end
