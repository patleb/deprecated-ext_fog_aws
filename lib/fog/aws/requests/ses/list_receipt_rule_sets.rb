module Fog
  module Parsers
    module AWS
      module SES
        class ListReceiptRuleSets < Fog::Parsers::AWS::Base
          # https://docs.aws.amazon.com/ses/latest/APIReference/API_ListReceiptRuleSets.html
          def self.aws_schema
            {
              'NextToken' => :string,
              'RuleSets' => [{
                'Name' => :string,
                'CreatedTimestamp' => :time,
              }]
            }
          end
        end
      end
    end
  end
  module AWS
    class SES
      class Real
        def list_receipt_rule_sets(options = {})
          request({
            'Action'  => 'ListReceiptRuleSets',
            :parser   => Fog::Parsers::AWS::SES::ListReceiptRuleSets.new
          }.merge!(options))
        end
      end
    end
  end
end
