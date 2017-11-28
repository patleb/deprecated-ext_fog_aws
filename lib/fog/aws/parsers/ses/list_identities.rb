module Fog
  module Parsers
    module AWS
      module SES
        class ListIdentities < Fog::Parsers::Base
          def reset
            @identity = {}
            @response = { 'ResponseMetadata' => {}, 'Identities' => [] }
          end

          def end_element(name)
            case name
            when 'member'
              @identity['Domain'] = value
              @response['Identities'] << @identity
              @identity = {}
            when 'RequestId'
              @response['ResponseMetadata'][name] = value
            when 'NextToken'
              response[name] = value
            end
          end
        end
      end
    end
  end
end
