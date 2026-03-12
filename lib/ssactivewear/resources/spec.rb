# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Spec < Base
      def list(**params)
        get("specs/", params)
      end

      def find(id, **params)
        get("specs/#{id}", params)
      end
    end
  end
end
