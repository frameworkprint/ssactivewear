# frozen_string_literal: true

module Ssactivewear
  module Resources
    class PaymentProfile < Base
      def list(email:, **params)
        get("paymentprofiles/", params.merge(email: email))
      end
    end
  end
end
