require 'fog/aws/models/iam/ssh_public_key'

module Fog
  module AWS
    class IAM
      class SshPublicKeys < Fog::Collection
        model Fog::AWS::IAM::SshPublicKey

        def initialize(attributes = {})
          @username = attributes[:username]
          super
        end

        def all
          data = service.list_ssh_public_keys('UserName'=> @username).body['SSHPublicKeys']
          load(data)
        end

        def get(identity)
          self.all.select {|ssh_public_key| ssh_public_key.id == identity}.first
        end

        def new(attributes = {})
          super({username: @username }.merge!(attributes))
        end
      end
    end
  end
end
