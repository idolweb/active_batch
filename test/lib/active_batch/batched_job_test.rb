require 'test_helper'

module ActiveBatch
  class BatchedJobTest < ActiveSupport::TestCase

    test 'can save work result' do
      @batched_job = BatchJob.new
      @work_unit = WorkUnit.create(job_id: @batched_job.job_id)
      @batched_job.save_result('blah')
      assert_equal 'blah', @work_unit.reload.work_result
    end

    test 'sets status to failed on exception' do
      @rescue_job = RescueJob.new
      @work_unit = WorkUnit.create(job_id: @rescue_job.job_id)
      @rescue_job.perform_now rescue nil
      assert @work_unit.reload.failed?
    end

  end
end