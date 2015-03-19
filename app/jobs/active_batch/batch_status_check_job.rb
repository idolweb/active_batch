module ActiveBatch
  class BatchStatusCheckJob < ActiveJob::Base

    queue_as do
      batch = arguments.first
      batch.job.new.queue_name
    end

    def perform(batch)
      if batch.work_units.not_done.exists?
        self.class.set(wait: 1.minute).perform_later(batch)
      else
        batch.perform_after_batch
      end
    end
  end
end
