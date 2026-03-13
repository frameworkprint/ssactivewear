# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Return < Base
      def list(**params)
        get("returns/", params)
      end

      def find(id, **params)
        get("returns/#{id}", params)
      end

      def create(body = {})
        post("returns/", body)
      end

      def cancel(order_number)
        delete("returns/#{order_number}")
      end
    end
  end
end
