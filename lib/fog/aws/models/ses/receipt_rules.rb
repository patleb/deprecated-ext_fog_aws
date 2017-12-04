require 'fog/aws/models/ses/receipt_rule'

module Fog
  module AWS
    class SES
      class ReceiptRules < Fog::Collection
        model Fog::AWS::SES::ReceiptRule

        def all
          data = service.describe_active_receipt_rule_set.body
          rule_set_name = data['Metadata']['Name']
          data = data['Rules'].map{ |rule| rule['RuleSetName'] = rule_set_name; rule }
          load(data)
        end

        def get(name)
          self.all.select{ |rule| rule.name == name }.first
        end
      end
    end
  end
end
