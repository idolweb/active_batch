module ActiveBatch
  class BatchSchedulerJob < ActiveJob::Base
    queue_as :default

    def perform(job_class, *args)
      batch = Batch.create(job_class: job_class, job_id: job_id, arguments: args.to_json)
      batch.job.each_work_unit(*args) do |*work_unit_args|
        work_unit_job = batch.job.perform_later(work_unit_args)
        batch.work_units.create(job_id: work_unit_job.job_id)
      end
      BatchStatusCheckJob.perform_later(batch)
      self
    end
  end
end
