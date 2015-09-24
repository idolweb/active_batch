module ActiveBatch
  class BatchSchedulerJob < ActiveJob::Base

    queue_as do
      job_class = arguments.first
      job_class.new.queue_name
    end

    def perform(job_class, *args)
      batch = Batch.create(job_class: job_class, job_id: job_id, arguments: args)
      batch.job.each_work_unit(*args) do |*work_unit_args|
        work_unit_job = batch.job.new(*work_unit_args)
        work_unit_job.in_batch = true
        batch.work_units.create(job_id: work_unit_job.job_id, arguments: work_unit_args)
        work_unit_job.enqueue
      end
      BatchStatusCheckJob.perform_later(batch)
      self
    end
  end
end
