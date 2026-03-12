# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Style < Base
      def list(**params)
        get("styles/", params)
      end

      def find(id, **params)
        get("styles/#{id}", params)
      end

      def search(query, **params)
        get("styles/", params.merge(search: query))
      end
    end
  end
end
