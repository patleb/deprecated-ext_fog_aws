require 'fog/aws/ses'

module Fog
  module AWS
    SES.class_eval do
      # request :create_receipt_rule
      # request :delete_receipt_rule
      request :delete_identity
      request :describe_active_receipt_rule_set
      request :list_identities
      request :list_receipt_rule_sets
      request :verify_domain_dkim

      model_path 'fog/aws/models/ses'
      model       :domain
      collection  :domains
      model       :receipt_rule
      collection  :receipt_rules
    end
  end
end
