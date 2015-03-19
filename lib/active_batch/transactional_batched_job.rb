require 'active_support/concern'

module ActiveBatch
  module TransactionalBatchedJob
    extend ActiveSupport::Concern

    included do
      around_perform do |job, block|
        ActiveRecord::Base.transaction do
          block.call
        end
      end
    end
  end
end