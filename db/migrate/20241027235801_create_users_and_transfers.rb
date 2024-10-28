class CreateUsersAndTransfers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.float :balance
      t.integer :cpf

      t.timestamps
    end

    create_table :transfers do |t|
      t.string :institution
      t.string :type
      t.float :value
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.date :date

      t.timestamps
    end
  end
end
