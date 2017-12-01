module Fog
  module Parsers
    module AWS
      module IAM
        class UploadSshPublicKey < Fog::Parsers::AWS::Base
          # https://docs.aws.amazon.com/IAM/latest/APIReference/API_UploadSSHPublicKey.html
          def self.aws_schema
            {
              'SSHPublicKey' => {
                'Fingerprint' => :string,
                'SSHPublicKeyBody' => :string,
                'SSHPublicKeyId' => :string,
                'Status' => 'Active|Inactive',
                'UploadDate' => :time,
                'UserName' => :string,
              }
            }
          end
        end
      end
    end
  end
  module AWS
    class IAM
      class Real
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
