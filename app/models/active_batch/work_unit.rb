module ActiveBatch
  class WorkUnit < ActiveRecord::Base

    enum status: [:enqueued, :running, :done, :failed]

    scope :not_done, -> { where.not(status: statuses[:done]) }

    belongs_to :batch, foreign_key: 'active_batch_batches_id'

    def error(exception)
      self.update!(
          status: :failed,
          work_result: "#{exception.message}\n#{exception.backtrace.join("\n")}"
      )
    end
  end
end
