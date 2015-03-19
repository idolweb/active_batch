class BatchJob < ActiveJob::Base
  include ActiveBatch::BatchedJob

  queue_as :test_queue

  def self.each_work_unit(string)
    string.each_char do |char|
      yield char
    end
  end

  def self.after_batch(args, results)

  end

  def perform(char)
    puts char
  end

end