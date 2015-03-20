require 'active_support/concern'

module ActiveBatch
  module BatchedJob
    extend ActiveSupport::Concern

    def work_unit_in_batch(job)
      WorkUnit.find_by(job_id: job.job_id)
    end

    def save_result(result)
      work_unit_in_batch(self).update!(work_result: result.to_s)
    end

    included do
      rescue_from(StandardError) do |exception|
        work_unit_in_batch(self).error(exception)
        raise exception
      end

      before_perform do |job|
        work_unit_in_batch(job).status = 'running'
      end

      after_perform do |job|
        work_unit_in_batch(job).status = 'done'
      end
    end
  end
end