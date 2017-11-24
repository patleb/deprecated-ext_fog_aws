module Fog
  module AWS
    class IAM
      class Real
        require 'fog/aws/parsers/iam/basic'

        # https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteSSHPublicKey.html

        def delete_ssh_public_key(ssh_public_key_id, username)
          request({
            'SSHPublicKeyId' => ssh_public_key_id,
            'UserName'       => username,
            'Action'         => 'DeleteSSHPublicKey',
            :parser          => Fog::Parsers::AWS::IAM::Basic.new
          })
        end
      end
    end
  end
end
