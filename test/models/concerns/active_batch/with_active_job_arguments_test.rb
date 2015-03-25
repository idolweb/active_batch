require 'test_helper'

module ActiveBatch
  class WithActiveJobArgumentsTest < ActiveSupport::TestCase

    setup do
      build_model :dummy do
        string :arguments

        include WithActiveJobArguments
      end
      @arguments = [1, { 'a' => 3 }, Batch.create]
    end

    test 'serializes active job arguments' do
      dummy = Dummy.create(arguments: @arguments)
      assert_equal @arguments, Dummy.find(dummy.id).arguments
    end

  end
end
