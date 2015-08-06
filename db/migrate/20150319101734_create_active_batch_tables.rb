class CreateActiveBatchTables < ActiveRecord::Migration
  def change
    create_table :active_batch_batches do |t|
      t.string :job_class
      t.string :job_id
      t.string :arguments
      t.integer :status, default: 0

      t.timestamps null: false
    end

    create_table :active_batch_work_units do |t|
      t.string :job_id
      t.integer :status, default: 0, index: true
      t.string :work_result
      t.string :arguments
      t.references :active_batch_batches, index: true

      t.timestamps null: false
    end
  end
end
