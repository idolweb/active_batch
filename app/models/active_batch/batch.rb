require 'json'

module ActiveBatch
  class Batch < ActiveRecord::Base
    include ActiveJob::Arguments

    has_many :work_units, foreign_key: 'active_batch_batches_id'

    enum status: %i(open closed)

    def perform_after_batch
      job.after_batch(*arguments, work_units.map(&:work_result))
      update!(status: :closed)
    end

    def arguments=(arguments)
      write_attribute(:arguments, serialize(arguments).to_json)
    end

    def arguments
      deserialize(JSON.parse(read_attribute(:arguments)))
    end

    def job
      @job ||= job_class.constantize
    end
  end
end
