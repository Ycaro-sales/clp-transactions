class RemoveDate < ActiveRecord::Migration[7.2]
  def change
    remove_column :transfers, :date
  end
end
