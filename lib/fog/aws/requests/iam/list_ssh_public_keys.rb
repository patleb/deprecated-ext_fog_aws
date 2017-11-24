module Fog
  module AWS
    class IAM
      class Real
        require 'fog/aws/parsers/iam/list_ssh_public_keys'

        # https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListSSHPublicKeys.html

        def list_ssh_public_keys(options = {})
          request({
            'Action'  => 'ListSSHPublicKeys',
            :parser   => Fog::Parsers::AWS::IAM::ListSshPublicKeys.new
          }.merge!(options))
        end
      end
    end
  end
end
