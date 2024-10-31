class CreateUsersAccountsTransferAndDependencies < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string  :name, null: false
      t.string  :email
    end

    create_table :accounts do |t|
      t.belongs_to :user, foreign_key: true, null: true
      t.string     :institution, null: false
    end

    create_table :pix_keys, id: false do |t|
      t.string     :key, null: false, primary_key: true
      t.belongs_to :account, foreign_key: true, null: false
    end

    create_table :transfers do |t|
      t.integer    :transfer_type, null: false
      t.float      :value, null: false, scale: 2
      t.references :sender, null: false, foreign_key: { to_table: :accounts }
      t.references :receiver, null: false, foreign_key: { to_table: :accounts }
      t.date       :date, null: false

      t.timestamps
    end
  end
end
