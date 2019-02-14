module Fog
  Service.class_eval do
    class << self
      def extend_request(request)
        index = requests.index{ |_path, name| name == request }
        requests[index][0] = File.join('ext', @request_path)
      end

      def extend_model(model)
        index = model_files.index{ |_path, name| name == model }
        model_files[index][0] = File.join('ext', @model_path)
      end

      def extend_collection(collection)
        index = collection_files.index{ |_path, name| name == collection }
        collection_files[index][0] = File.join('ext', @model_path)
      end
    end
  end
end
