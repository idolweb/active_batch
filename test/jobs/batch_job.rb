class BatchJob < ActiveJob::Base
  include ActiveBatch::BatchedJob

  queue_as :test_queue

  def self.each_work_unit(string)
    string.each_char do |char|
      yield char
    end
  end

  def self.after_batch(args, results)
    File.open('/tmp/batch_job_arguments', 'w') { |f| f << args }
    File.open('/tmp/batch_job_result', 'w') { |f| f << results }
  end

  def perform(char)
    save_result(char)
  end

end