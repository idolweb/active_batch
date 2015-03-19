class CreateActiveBatchWorkUnits < ActiveRecord::Migration
  def change
    create_table :active_batch_work_units do |t|
      t.string :job_id
      t.integer :status, default: 0
      t.string :work_result
      t.references :active_batch_batches

      t.timestamps null: false
    end
  end
end
