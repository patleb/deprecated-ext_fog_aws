module Fog
  module Parsers
    module AWS
      module SES
        class DeleteIdentity < Fog::Parsers::AWS::Base
          # https://docs.aws.amazon.com/ses/latest/APIReference/API_DeleteIdentity.html
        end
      end
    end
  end
  module AWS
    class SES
      class Real
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
