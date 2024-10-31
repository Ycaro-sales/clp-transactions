class CreateUsersAndTransfers < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.bool :is_third_party
      t.float :balance, default: 0
      t.belongs_to :user, foreign_key: true
    end

    create_table :users do |t|
      t.string :name
      t.integer :cpf

      t.timestamps
    end

    create_table :transfers do |t|
      t.string :institution
      t.string :type
      t.float :value
      t.references :sender, null: false, foreign_key: { to_table: :accounts }
      t.references :receiver, null: false, foreign_key: { to_table: :accounts }
      t.date :date

      t.timestamps
    end
  end
end
