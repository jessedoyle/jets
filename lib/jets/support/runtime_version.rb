module Jets
  module Support
    class RuntimeVersion
      attr_accessor :base

      def initialize(base: RUBY_VERSION)
        self.base = base
      end

      def local
        Gem::Version.new(base)
      end

      def runtime
        resolved_runtime || invalid_runtime!
      end

      private

      def resolved_runtime
        Jets::SUPPORTED_RUNTIMES.find do |runtime|
          Gem::Requirement.create(runtime[:constraint]).satisfied_by?(local)
        end
      end

      def invalid_runtime!
        versions = Jets::SUPPORTED_RUNTIMES.map { |v| v[:constraint] }.join("\n")

        message = <<~EOF
        You are using Ruby version #{base} which is not supported by Jets.

        Jets currently supports the following Ruby versions:

        #{versions}
        EOF

        raise Jets::Error, message.color(:red)
      end
    end
  end
end
