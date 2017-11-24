module Fog
  module AWS
    IAM.class_eval do
      request :delete_ssh_public_key
      request :list_ssh_public_keys
      request :upload_ssh_public_key

      model       :ssh_public_key
      collection  :ssh_public_keys

      extend_model :group
    end
  end
end
