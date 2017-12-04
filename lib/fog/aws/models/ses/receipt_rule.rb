module Fog
  module AWS
    class SES
      class ReceiptRule < Fog::Model
        identity  :name, aliases: 'Name'
        attribute :actions, aliases: 'Actions', type: :array
        attribute :enabled, aliases: 'Enabled', type: :boolean
        attribute :recipients, aliases: 'Recipients', type: :array
        attribute :scan_enabled, aliases: 'ScanEnabled', type: :boolean
        attribute :tls_policy, aliases: 'TlsPolicy'
        attribute :rule_set_name, aliases: 'RuleSetName'

        def save
          requires :name
          requires :rule_set_name

          raise NotImplementedError

          # TODO doesn't work
          rule = dup_attributes!
          self.class.aliases.each do |aliases, name|
            rule[aliases] = rule.delete(name) if rule.key?(name)
          end
          service.create_receipt_rule(rule, rule.delete('RuleSetName'))
          true
        end

        def destroy
          requires :name
          requires :rule_set_name

          raise NotImplementedError

          # TODO doesn't work
          service.delete_receipt_rule(name, rule_set_name)
          true
        end

        def void!(domain, options = {})
          merge_attributes({
            'Actions' => [
              {
                'StopAction' => {
                  'Scope' => 'RuleSet'
                }
              }
            ],
            'Enabled' => true,
            'Name' => "void-#{domain}",
            'Recipients' => [
              domain
            ],
            'ScanEnabled' => true,
            'TlsPolicy' => 'Require',
            'RuleSetName' => 'default-rule-set',
          }.merge!(options))

          self
        end
      end
    end
  end
end
