module Fog
  module AWS
    SES.class_eval do
      request :delete_identity
      request :list_identities
      request :verify_domain_dkim

      model_path 'fog/aws/models/ses'
      model       :domain
      collection  :domains
    end
  end
end
