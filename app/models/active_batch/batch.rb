require 'json'

module ActiveBatch
  class Batch < ActiveRecord::Base
    include WithActiveJobArguments

    has_many :work_units, foreign_key: 'active_batch_batches_id'

    enum status: %i(open closed)

    def perform_after_batch
      job.after_batch(*arguments, work_units.map(&:work_result))
      update!(status: :closed)
    end

    def job
      @job ||= job_class.constantize
    end
  end
end
