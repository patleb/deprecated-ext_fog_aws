module Fog
  module Parsers
    module AWS
      module SES
        class ListIdentities < Fog::Parsers::AWS::Base
          # https://docs.aws.amazon.com/ses/latest/APIReference/API_ListIdentities.html
          def self.aws_schema
            {
              'Identities' => [:string],
              'NextToken' => :string,
            }
          end
        end
      end
    end
  end
  module AWS
    class SES
      class Real
        def list_identities(options = {})
          request({
            'Action'  => 'ListIdentities',
            :parser   => Fog::Parsers::AWS::SES::ListIdentities.new
          }.merge!(options))
        end
      end
    end
  end
end
