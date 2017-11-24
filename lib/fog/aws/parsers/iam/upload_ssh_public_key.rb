module Fog
  module Parsers
    module AWS
      module IAM
        class UploadSshPublicKey < Fog::Parsers::Base
          def reset
            @response = { 'SSHPublicKey' => {} }
          end

          def end_element(name)
            case name
            when 'Fingerprint', 'SSHPublicKeyBody', 'SSHPublicKeyId', 'Status', 'UserName'
              @response['SSHPublicKey'][name] = value
            when 'UploadDate'
              @response['SSHPublicKey'][name] = Time.parse(value)
            when 'RequestId'
              @response[name] = value
            end
          end
        end
      end
    end
  end
end
