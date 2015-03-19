class CreateActiveBatchBatches < ActiveRecord::Migration
  def change
    create_table :active_batch_batches do |t|
      t.string :job_class
      t.string :job_id
      t.string :arguments

      t.timestamps null: false
    end
  end
end
