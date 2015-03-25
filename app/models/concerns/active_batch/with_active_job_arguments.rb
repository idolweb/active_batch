module ActiveBatch
  module WithActiveJobArguments
    extend ActiveSupport::Concern
    include ActiveJob::Arguments

    def arguments=(arguments)
      write_attribute(:arguments, serialize(arguments).to_json)
    end

    def arguments
      deserialize(JSON.parse(read_attribute(:arguments)))
    end
  end
end