module Fog
  module AWS
    class IAM
      class Real
        require 'fog/aws/parsers/iam/upload_ssh_public_key'

        # https://docs.aws.amazon.com/IAM/latest/APIReference/API_UploadSSHPublicKey.html

        def upload_ssh_public_key(public_key, username)
          request({
            'Action'              => 'UploadSSHPublicKey',
            'SSHPublicKeyBody'    => public_key,
            'UserName'            => username,
            :parser               => Fog::Parsers::AWS::IAM::UploadSshPublicKey.new
          })
        end
      end
    end
  end
end
