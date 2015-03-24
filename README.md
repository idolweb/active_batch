# Active Batch

Active Batch allows the management and execution of batch of Active Jobs. It is useful when an action must be perform when and
only when a list of tasks has been completed and you want to execute this list of tasks in parallel.
It can also be seen as some kind of map / reduce on top of Active Job.

## Installation

### Compatible with Rails 4 only (Uses ActiveJob)

1. Add ActiveBatch to your `Gemfile`:

    `gem 'active_batch'`

2. And then execute:

    `$ bundle`

3. Generate a migration which will add the required tables to your database.

    `$ rake active_batch:install:migrations`

4. Run the migration.

    `$ bundle exec rake db:migrate`

## Usage

Declare a job like so:

```ruby
class MyBatchJob < ActiveJob::Base
  include ActiveBatch::BatchedJob

  queue_as :my_queue

  # Yields parameters to be used by each task
  self.each_work_unit(max)
    [0..max].each { |i| yield i }
  end

  # Actual work perform for each task
  def perform(i)
    result = expensive_computation(i)
    save_result(result) # This saves the result that will be passed to the "reduce" part (self.after_batch)
  end

  # Executed only once all tasks are complete
  def self.after_batch(max, results)
    reduce(results)
  end
end
```

Enqueue the whole batch like so:

```ruby
MyBatchJob.perform_batch(100)
```

You can mount a dashboard with all the batches and their status in your `config/routes.rb`:

```ruby
mount ActiveBatch::Engine, at: "batches"
```

## Contributing

1. Fork it ( https://github.com/idolweb/active_batch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request