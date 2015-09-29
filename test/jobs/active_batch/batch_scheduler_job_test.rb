require 'test_helper'

module ActiveBatch
  class BatchSchedulerJobTest < ActiveJob::TestCase

    setup do
      @batch_job = 'BatchJob'
      @test_string = 'test'
    end

    test 'enqueues work unit jobs and check job' do
      BatchSchedulerJob.perform_now(@batch_job, @test_string)
      assert_enqueued_jobs(@test_string.length + 1)
    end

    test 'creates batch' do
      assert_difference('WorkUnit.count', @test_string.length) do
        BatchSchedulerJob.perform_now(@batch_job, @test_string)
      end
    end

    test 'creates work units' do
      assert_difference('Batch.count', 1) do
        BatchSchedulerJob.perform_now(@batch_job, @test_string)
      end
    end

    test 'batch has work units' do
      job = BatchSchedulerJob.perform_now(@batch_job, @test_string)
      batch = Batch.find_by(job_id: job.job_id)
      assert_equal @test_string.length, batch.work_units.count
    end

    test 'work units have enqueued status' do
      job = BatchSchedulerJob.perform_now(@batch_job, @test_string)
      batch = Batch.find_by(job_id: job.job_id)
      assert_equal @test_string.length, batch.work_units.enqueued.count
    end

    test 'uses same queue than the Batch Job' do
      assert_enqueued_with(job: BatchSchedulerJob, queue: BatchJob.new.queue_name) do
        BatchSchedulerJob.perform_later(BatchJob.name)
      end
    end
  end
end
