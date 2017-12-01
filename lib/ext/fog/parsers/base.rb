require 'fog/parsers/base'

module Fog
  module Parsers
    Base.class_eval do
      def self.aws_schema
        nil
      end

      module WithSchema
        def reset
          super
          return unless (@schema = self.class.aws_schema)

          @response['ResponseMetadata'] = {}
          @nodes = NodeList.new(@response, @schema)
        end

        def start_element(name, attrs = [])
          super
          return unless @schema

          @nodes.start_element name
        end

        def end_element(name)
          return super unless @schema

          @nodes.end_element name, value
        end

        class NodeList < Array
          def initialize(*args)
            @response, @schema = args
            super()
          end

          def root?
            empty?
          end

          def child_node?(name)
            current_node.next_schema.has_key? name
          end

          def current_node
            last
          end

          def start_element(name)
            if root?
              if @schema.has_key? name
                self << new_node(name, @schema, @response)
              end
            elsif current_node
              if name == 'member'
                self << current_node.new_member
              elsif child_node? name
                self << new_node(name, current_node.next_schema, current_node.next_result)
              end
            end
          end

          def end_element(name, value)
            if name == 'RequestId'
              @response['ResponseMetadata'][name] = value
            elsif current_node
              if name == 'member'
                current_node.update_result(value)
                pop
              elsif current_node.name == name
                current_node.update_result(value)
                pop
              end
            end
          end

          def new_node(name, schema_pointer, result_pointer)
            node_class =
              case schema_pointer[name]
              when Hash
                NodeHash
              when Array
                NodeArray
              else
                NodeValue
              end
            node_class.new(name, schema_pointer, result_pointer)
          end
        end

        class Node
          attr_reader :name

          def initialize(name, schema_pointer, result_pointer, index = nil)
            @name = name
            @schema_pointer = schema_pointer
            @result_pointer = result_pointer
            @index = index
          end

          def update_result(_value)
            # do nothing
          end

          def next_schema; raise NotImplementedError end
          def next_result; raise NotImplementedError end
        end

        class NodeHash < Node
          def initialize(*_)
            super
            @index ? @result_pointer[name][@index] = {} : @result_pointer[name] = {}
          end

          def next_schema
            _next_schema.is_a?(Hash) ? _next_schema : {}
          end

          def next_result
            _next_schema.is_a?(Hash) ? _next_result : {}
          end

          private

          def _next_schema
            @index ? @schema_pointer[name].first : @schema_pointer[name]
          end

          def _next_result
            @index ? @result_pointer[name][@index] : @result_pointer[name]
         end
        end

        class NodeValue < Node
          def next_schema
            {}
          end

          def next_result
            {}
          end

          def update_result(value)
            @index ? @result_pointer[name][@index] = cast(value) : @result_pointer[name] = cast(value)
          end

          private

          def cast(value)
            case @schema_pointer[name]
            when :boolean
              value == 'true'
            when :time
              Time.parse(value)
            else
              value
            end
          end
        end

        class NodeArray < Node
          def initialize(*_)
            super
            @count = 0
            @result_pointer[name] = []
          end

          def next_schema
            @schema_pointer[name].first
          end

          def new_member
            member_class = next_schema.is_a?(Hash) ? NodeHash : NodeValue
            member = member_class.new(name, @schema_pointer, @result_pointer, @count)
            @count += 1
            member
          end
        end
      end
      prepend WithSchema
    end
  end
end
