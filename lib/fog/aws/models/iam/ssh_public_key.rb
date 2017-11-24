module Fog
  module AWS
    class IAM
      class SshPublicKey < Fog::Model
        identity  :id, :aliases => 'SSHPublicKeyId'
        attribute :body, :aliases => 'SSHPublicKeyBody'
        attribute :fingerprint, :aliases => 'Fingerprint'
        attribute :status, :aliases => 'Status'
        attribute :upload_date, :aliases => 'UploadDate'
        attribute :username, :aliases => 'UserName'

        def save
          requires :body
          requires :username

          data = service.upload_ssh_public_key(body, username).body["SSHPublicKey"]
          merge_attributes(data)
          true
        end

        def destroy
          requires :id
          requires :username

          service.delete_ssh_public_key(id, username)
          true
        end

        def user
          requires :username
          service.users.get(username)
        end
      end
    end
  end
end
