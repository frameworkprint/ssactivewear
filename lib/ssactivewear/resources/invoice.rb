# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Invoice < Base
      def list(**params)
        get("invoices/", params)
      end

      def find(id, **params)
        get("invoices/#{id}", params)
      end
    end
  end
end
