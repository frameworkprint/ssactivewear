# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Base
      attr_reader :client

      def initialize(client)
        @client = client
      end

      private

      def get(path, params = {})
        client.get(path, params)
      end

      def post(path, body = {})
        client.post(path, body)
      end

      def put(path, body = {})
        client.put(path, body)
      end

      def delete(path, params = {})
        client.delete(path, params)
      end
    end
  end
end
