# frozen_string_literal: true

module Ssactivewear
  module Resources
    class CrossReference < Base
      def list(**params)
        get("crossref/", params)
      end

      def find(your_sku, **params)
        get("crossref/#{your_sku}", params)
      end

      def upsert(your_sku, identifier:)
        put("crossref/#{your_sku}?Identifier=#{identifier}")
      end

      def remove(your_sku)
        delete("crossref/#{your_sku}")
      end
    end
  end
end
