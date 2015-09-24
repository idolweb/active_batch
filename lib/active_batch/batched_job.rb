require 'active_support/concern'

module ActiveBatch
  module BatchedJob
    extend ActiveSupport::Concern

    def work_unit_in_batch(job)
      WorkUnit.find_by(job_id: job.job_id)
    end

    def save_result(result)
      work_unit_in_batch(self).update!(work_result: result.to_s) if in_batch
    end

    class_methods do
      def perform_batch(*args)
        BatchSchedulerJob.perform_later(self, *args)
      end
    end

    included do

      attr_accessor :in_batch

      rescue_from(StandardError) do |exception|
        work_unit_in_batch(self).error(exception) if in_batch
        raise exception
      end

      before_perform do |job|
        work_unit_in_batch(job).update!(status: :running) if job.in_batch
      end

      after_perform do |job|
        work_unit_in_batch(job).update!(status: :done)  if job.in_batch
      end
    end
  end
end