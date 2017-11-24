module Fog
  module Parsers
    module AWS
      module IAM
        class ListSshPublicKeys < Fog::Parsers::Base
          def reset
            @ssh_public_key = {}
            @response = { 'SSHPublicKeys' => [] }
          end

          def end_element(name)
            case name
            when 'SSHPublicKeyId', 'Status', 'UploadDate', 'UserName'
              @ssh_public_key[name] = value
            when 'member'
              @response['SSHPublicKeys'] << @ssh_public_key
              @ssh_public_key = {}
            when 'IsTruncated'
              response[name] = (value == 'true')
            when 'Marker', 'RequestId'
              response[name] = value
            end
          end
        end
      end
    end
  end
end
