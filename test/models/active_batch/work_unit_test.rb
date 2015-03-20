require 'test_helper'

module ActiveBatch
  class JobTest < ActiveSupport::TestCase

    setup do
      @done_work_unit = WorkUnit.create(status: :done)
      @running_work_unit = WorkUnit.create(status: :running)
      @enqueued_work_unit = WorkUnit.create(status: :enqueued)
    end

    test 'not done scope returns work unit not done' do
      assert_includes WorkUnit.not_done, @running_work_unit
      assert_includes WorkUnit.not_done, @enqueued_work_unit
      refute_includes WorkUnit.not_done, @done_work_unit
    end

  end
end
