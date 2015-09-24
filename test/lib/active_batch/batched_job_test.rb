require 'test_helper'

module ActiveBatch
  class BatchedJobTest < ActiveSupport::TestCase

    test 'can save work result when in batch' do
      @batched_job = BatchJob.new
      @batched_job.in_batch = true
      @work_unit = WorkUnit.create(job_id: @batched_job.job_id)
      @batched_job.save_result('blah')
      assert_equal 'blah', @work_unit.reload.work_result
    end

    test 'sets status to failed on exception when in batch' do
      @rescue_job = RescueJob.new
      @rescue_job.in_batch = true
      @work_unit = WorkUnit.create(job_id: @rescue_job.job_id)
      @rescue_job.perform_now rescue nil
      assert @work_unit.reload.failed?
    end

    test 'can perform batch' do
      assert_enqueued_with(job: BatchSchedulerJob, args: [BatchJob, 1, 2]) do
        BatchJob.perform_batch(1, 2)
      end
    end
  end
end