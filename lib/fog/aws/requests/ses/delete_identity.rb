module Fog
  module AWS
    class SES
      class Real
        require 'fog/aws/parsers/ses/delete_identity'

        # https://docs.aws.amazon.com/ses/latest/APIReference/API_DeleteIdentity.html

        def delete_identity(name)
          request({
            'Action'       => 'DeleteIdentity',
            'Identity'     => name,
            :parser        => Fog::Parsers::AWS::SES::DeleteIdentity.new
          })
        end
      end
    end
  end
end
