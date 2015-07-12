require 'active_support/concern'

module ActiveRecordSorting
  module Concern
    extend ActiveSupport::Concern

    included do
      def self.sort(order)
        klass = "#{self}Sorting".constantize rescue ActiveRecordSorting::Base
        klass.new(where(nil)).sort(order)
      end
    end
  end
end
