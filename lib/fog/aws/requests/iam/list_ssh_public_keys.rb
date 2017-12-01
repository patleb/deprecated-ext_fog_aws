module Fog
  module Parsers
    module AWS
      module IAM
        class ListSshPublicKeys < Fog::Parsers::Base
          # https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListSSHPublicKeys.html
          def self.aws_schema
            {
              'IsTruncated' => :boolean,
              'Marker' => :string,
              'SSHPublicKeys' => [{
                'SSHPublicKeyId' => :string,
                'Status' => 'Active|Inactive',
                'UploadDate' => :time,
                'UserName' => :string,
              }]
            }
          end
        end
      end
    end
  end
  module AWS
    class IAM
      class Real
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
