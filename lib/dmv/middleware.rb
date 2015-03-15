require 'middleware'

module DMV
  # Middleware wraps around Middleware::Builder in order to give us
  # proper cloning for use in inheritance
  #
  class Middleware
    attr_reader :builder

    def initialize
      @builder = ::Middleware::Builder.new
    end

    def method_missing(name, *args, &block)
      if @builder.respond_to?(name)
        return @builder.send(name, *args, &block)
      end

      super
    end

    def stack
      @builder.send(:stack)
    end

    def clone
      cloned = self.class.new
      cloned.use builder
      cloned
    end
  end
end