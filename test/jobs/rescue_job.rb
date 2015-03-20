class RescueJob < ActiveJob::Base
  include ActiveBatch::BatchedJob

  queue_as :test_queue

  def perform
    raise StandardError.new
  end
end