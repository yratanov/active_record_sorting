require 'active_support/core_ext/class/attribute_accessors'

module ActiveRecordSorting
  class Base
    cattr_accessor(:sorting_orders) { [] }

    attr_accessor :scope

    # If simple order like "id_asc" is not enough, you can create complicated orders using this method.
    # @param sortings Array
    def self.named_sorting_orders(*sortings)
      self.sorting_orders = sortings
    end

    def initialize(scope)
      @scope = scope
    end

    def self.sort(scope, order)
      new(scope).sort(order)
    end

    # Parses +sort_order+, applies sorting to scope and return it.
    # @param sort_order String Examples: 'id_asc', 'created_at_desc', 'relation.column_asc', 'named_order_asc'
    def sort(sort_order)
      return scope unless sort_order.present?

      column, direction = parse_order sort_order

      if sorting_orders.include? column.to_sym
        send column.to_sym, direction
      elsif scope.column_names.include?(column)
        column_sorting(column, direction)
      else
        relation_sorting(column, direction)
      end
    end

    private

    def sorting_orders
      self.class.sorting_orders
    end

    def parse_order(sort_order)
      sort_array = sort_order.split('_')
      direction = sort_array.pop
      unless %w(desc asc).include? direction.downcase
        raise "Invalid direction '#{direction}'"
      end
      column = sort_array.join('_')
      [column, direction]
    end

    def relation_sorting(column, direction)
      relation, attribute = column.split '.'
      association = scope.reflect_on_association(relation.to_sym)
      if association.present?
        scope.includes(association.name).
          order("#{association.table_name}.#{attribute} #{direction}")
      else
        scope
      end
    end

    def column_sorting(column, direction)
      scope.order("#{scope.table_name}.#{column} #{direction}")
    end
  end
end
