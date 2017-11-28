module Fog
  module AWS
    class SES
      class Domain < Fog::Model
        identity  :name, :aliases => 'Domain'
        attribute :verification_token, :aliases => 'VerificationToken'
        attribute :dkim_tokens, :aliases => 'DkimTokens'
        attribute :with_inbox, type: :boolean

        def save
          requires :name

          verification_token = service.verify_domain_identity(name).body['VerificationToken']
          dkim_tokens = service.verify_domain_dkim(name).body['DkimTokens']
          merge_attributes(verification_token: verification_token, dkim_tokens: dkim_tokens)
          true
        end

        def destroy
          requires :name

          service.delete_identity(name)
          true
        end

        def records
          ([verification_record] + dkim_records + [inbox_record]).compact
        end

        def verification_record
          if verification_token
            { name: "_amazonses.#{name}", value: %{"#{verification_token}"}, type: 'TXT' }
          else
            { name: "_amazonses.#{name}", type: 'TXT' }
          end
        end

        def dkim_records
          if dkim_tokens
            dkim_tokens.map{ |token| { name: "#{token}._domainkey.#{name}", value: "#{token}.dkim.amazonses.com", type: 'CNAME' } }
          else
            [{ name: "_domainkey.#{name}", type: 'CNAME' }]
          end
        end

        def inbox_record
          { name: name, value: "10 inbound-smtp.us-east-1.amazonaws.com", type: 'MX' } if with_inbox
        end
      end
    end
  end
end
