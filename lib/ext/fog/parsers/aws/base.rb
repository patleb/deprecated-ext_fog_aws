module Fog
  module Parsers
    module AWS
      class Base < Fog::Parsers::Base
        def self.schema
          aws_schema.merge!({
            'ResponseMetadata' => {
              'RequestId' => :string
            }
          })
        end

        def self.aws_schema
          {}
        end

        def self.member
          'member'
        end

        def reset
          super
          @response['ResponseMetadata'] = {}
        end
      end
    end
  end
end
