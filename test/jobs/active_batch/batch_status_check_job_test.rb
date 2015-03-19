require 'test_helper'

module ActiveBatch
  class BatchStatusCheckJobTest < ActiveJob::TestCase

    fixtures :all

    setup do
      @batch = active_batch_batches(:one)
      @work_unit_done = @batch.work_units.create(status: :done)
      @work_unit_running = @batch.work_units.create(status: :running)
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


  end
end
