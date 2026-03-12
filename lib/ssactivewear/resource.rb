# frozen_string_literal: true

module Ssactivewear
  class Resource
    def initialize(attrs = {})
      @attrs = {}
      attrs.each do |key, value|
        @attrs[underscore(key.to_s).to_sym] = coerce(value)
      end
    end

    def [](key)
      @attrs[underscore(key.to_s).to_sym]
    end

    def to_h
      @attrs
    end

    def respond_to_missing?(name, include_private = false)
      @attrs.key?(name) || super
    end

    def inspect
      "#<#{self.class.name} #{@attrs.map { |k, v| "#{k}=#{v.inspect}" }.join(" ")}>"
    end

    private

    def method_missing(name, *args)
      if @attrs.key?(name)
        @attrs[name]
      else
        super
      end
    end

    def underscore(str)
      str.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .downcase
    end

    def coerce(value)
      case value
      when Hash
        Resource.new(value)
      when Array
        value.map { |v| coerce(v) }
      else
        value
      end
    end
  end
end
