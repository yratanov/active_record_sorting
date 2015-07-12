require 'active_support/concern'

module ActiveRecordSorting
  module Concern
    extend ActiveSupport::Concern

    included do
      def self.sort(order)
        klass = "#{self.name}Sorting".constantize rescue ActiveRecordSorting::Base
        klass.new(self).sort(order)
      end
    end
  end
end
