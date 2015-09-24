require 'test_helper'

module ActiveBatch
  class BatchJobTest < ActiveJob::TestCase

    setup do
      @test_string = 'test'
    end

    test 'can be enqueued outside a batch' do
      BatchJob.perform_now(@test_string)
      assert_equal @test_string, IO.read('/tmp/batch_job_result')
    end
  end
end
