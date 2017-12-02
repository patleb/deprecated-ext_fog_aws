module Fog
  module Parsers
    module AWS
      module SES
        class DescribeActiveReceiptRuleSet < Fog::Parsers::AWS::Base
          # https://docs.aws.amazon.com/ses/latest/APIReference/API_DescribeActiveReceiptRuleSet.html
          def self.aws_schema
            {
              'Metadata' => {
                'Name' => :string,
                'CreatedTimestamp' => :time,
              },
              'Rules' => [{
                'Actions' => [{
                  'AddHeaderAction' => {
                    'HeaderName' => :string,
                    'HeaderValue' => :string,
                  },
                  'BounceAction' => {
                    'Message' => :string,
                    'Sender' => :string,
                    'SmtpReplyCode' => :string,
                    'StatusCode' => :string,
                    'TopicArn' => :string,
                  },
                  'LambdaAction' => {
                    'FunctionArn' => :string,
                    'InvocationType' => 'Event|RequestResponse',
                    'TopicArn' => :string,
                  },
                  'S3Action' => {
                    'BucketName' => :string,
                    'KmsKeyArn' => :string,
                    'ObjectKeyPrefix' => :string,
                    'TopicArn' => :string,
                  },
                  'SNSAction' => {
                    'Encoding' => 'UTF-8|Base64',
                    'TopicArn' => :string,
                  },
                  'StopAction' => {
                    'Scope' => 'RuleSet',
                    'TopicArn' => :string,
                  },
                  'WorkmailAction' => {
                    'OrganizationArn' => :string,
                    'TopicArn' => :string,
                  },
                }],
                'Enabled' => :boolean,
                'Name' => :string,
                'Recipients' => [:string],
                'ScanEnabled' => :boolean,
                'TlsPolicy' => 'Require|Optional',
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
        def describe_active_receipt_rule_set(options = {})
          request({
            'Action'  => 'DescribeActiveReceiptRuleSet',
            :parser   => Fog::Parsers::AWS::SES::DescribeActiveReceiptRuleSet.new
          }.merge!(options))
        end
      end
    end
  end
end
