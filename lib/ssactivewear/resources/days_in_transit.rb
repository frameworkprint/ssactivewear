# frozen_string_literal: true

module Ssactivewear
  module Resources
    class DaysInTransit < Base
      def find(zipcode, **params)
        get("daysintransit/#{zipcode}", params)
      end
    end
  end
end
