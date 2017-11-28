module Fog
  module AWS
    class SES
      class Real
        require 'fog/aws/parsers/ses/list_identities'

        # https://docs.aws.amazon.com/ses/latest/APIReference/API_ListIdentities.html

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
