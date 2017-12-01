module Fog
  module Parsers
    module AWS
      module SES
        class VerifyDomainDkim < Fog::Parsers::Base
          # https://docs.aws.amazon.com/ses/latest/APIReference/API_VerifyDomainDkim.html
          def self.aws_schema
            {
              'DkimTokens' => [:string]
            }
          end
        end
      end
    end
  end
  module AWS
    class SES
      class Real
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
