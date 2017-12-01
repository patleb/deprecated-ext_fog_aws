require 'fog/parsers/base'
require 'ext/fog/parsers/schema'

module Fog
  module Parsers
    Base.class_eval do
      prepend Schema

      def self.schema; end

      def self.arrays
        raise NotImplementedError
      end
    end
  end
end
