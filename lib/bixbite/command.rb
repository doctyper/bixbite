module Bixbite
  class Command
    attr_accessor :options

    def initialize options
      @config = options[:config]
      @options = options
    end

    def run!
      Bixbite::Create.new(@options)
    end
  end
end
