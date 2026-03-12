# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Order < Base
      def list(**params)
        get("orders/", params)
      end

      def find(id, **params)
        get("orders/#{id}", params)
      end

      def create(body = {})
        post("orders/", body)
      end

      def cancel(id)
        delete("orders/#{id}")
      end
    end
  end
end
