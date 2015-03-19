require 'json'

module ActiveBatch
  class Batch < ActiveRecord::Base

    has_many :work_units, foreign_key: 'active_batch_batches_id'

    def perform_after_batch
      job.after_batch(JSON.parse(arguments), work_units.map(&:work_result))
    end

    def job
      @job ||= job_class.constantize
    end
  end
end
