require 'fog/aws/models/iam/group'

module Fog
  module AWS
    class IAM
      Group.class_eval do
        def remove_user(user_or_name)
          requires :name

          user = if user_or_name.is_a?(Fog::AWS::IAM::User)
            user_or_name
          else
            service.users.new(:id => user_or_name)
          end

          service.remove_user_from_group(self.name, user.identity)
          merge_attributes(:users => self.users - [user])
        end
      end
    end
  end
end
