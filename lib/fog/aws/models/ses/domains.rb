require 'fog/aws/models/ses/domain'

module Fog
  module AWS
    class SES
      class Domains < Fog::Collection
        model Fog::AWS::SES::Domain

        def all
          data = service.list_identities('Type'=> 'Domain').body['Identities'].map{ |name| { 'Domain' => name } }
          load(data)
        end

        def get(domain, with_inbox: false)
          if (result = self.all.select{ |identity| identity.name == domain }.first)
            result.with_inbox = with_inbox
          end
          result
        end
      end
    end
  end
end
