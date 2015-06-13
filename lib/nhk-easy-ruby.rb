require 'json'

module NHK
  module Easy
    class Parser
      def initialize data={}
        @data = data
      end

      def parse!
        JSON.parse @data
      end
    end
  end
end
