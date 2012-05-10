module Haml
  module Filters
    module Typogruby
      include Haml::Filters::Base
      lazy_require 'typogruby'

      def render(text)
        ::Typogruby.improve(text)
      end
    end
  end
end
