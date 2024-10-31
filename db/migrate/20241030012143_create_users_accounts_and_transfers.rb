class CreateUsersAccountsAndTransfers < ActiveRecord::Migration[8.2]
  def change
    create_table :users do |t|
      t.string :name, optional: true
      t.integer :cpf, null: false

      t.timestamps
    end

    create_table :accounts do |t|
      t.boolean :is_third_party, null: false
      t.float :balance, default: 0, null: false
      t.belongs_to :user, foreign_key: true, null: false
    end

    create_table :transfers do |t|
      t.string :institution, null: false
      t.integer :transfer_type, null: false
      t.float :value, null: false
      t.references :sender, null: false, foreign_key: { to_table: :accounts }
      t.references :receiver, null: false, foreign_key: { to_table: :accounts }
      t.date :date, null: false

      t.timestamps
    end
  end
end
