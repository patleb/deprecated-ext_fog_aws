module Fog
  module AWS
    class SES
      class Real
        require 'fog/aws/parsers/ses/verify_domain_dkim'

        # https://docs.aws.amazon.com/ses/latest/APIReference/API_VerifyDomainDkim.html

        def verify_domain_dkim(domain)
          request({
            'Action'           => 'VerifyDomainDkim',
            'Domain'           => domain,
            :parser            => Fog::Parsers::AWS::SES::VerifyDomainDkim.new
          })
        end
      end
    end
  end
end
