class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.decimal :amount
      t.string :type
      t.string :status
      t.bigint :submitted_by, null: false  # Use t.bigint or t.integer instead of t.references

      t.timestamps
    end

    add_foreign_key :bills, :users, column: :submitted_by  # Explicitly add the foreign key constraint
    add_index :bills, :submitted_by  # Optionally, add an index on submitted_by for better performance
  end
end
