require 'test_helper'

module ActiveBatch
  class BatchStatusCheckJobTest < ActiveJob::TestCase

    fixtures :all

    def random_result
      rand(100).to_s
    end

    setup do
      @first_result = random_result
      @second_result = random_result
      @batch = active_batch_batches(:one)
      @work_unit_done = @batch.work_units.create(status: :done, work_result: @first_result)
      @work_unit_running = @batch.work_units.create(status: :running, work_result: @second_result)
    end

    test 'reenqueues itself later if batch is not done' do
      assert_enqueued_with(job: BatchStatusCheckJob, args: [@batch]) do
        BatchStatusCheckJob.perform_now(@batch)
      end
    end

    test 'uses the same queue than the work_units' do
      assert_enqueued_with(job: BatchStatusCheckJob, queue: 'test_queue') do
        BatchStatusCheckJob.perform_now(@batch)
      end
    end

    test 'does not reenqueue itself later if batch is done' do
      @work_unit_running.status = :done
      @work_unit_running.save
      assert_no_enqueued_jobs do
        BatchStatusCheckJob.perform_now(@batch)
      end
    end

    test 'calls after batch with proper args when batch is done' do
      @work_unit_running.update!(status: :done)
      BatchStatusCheckJob.perform_now(@batch)

      assert File.exists?('/tmp/batch_job_results')
      assert File.exists?('/tmp/batch_job_arguments')
      assert_equal @batch.arguments.first, IO.read('/tmp/batch_job_arguments')
      assert_equal [@first_result, @second_result].to_s, IO.read('/tmp/batch_job_results')
    end

  end
end
