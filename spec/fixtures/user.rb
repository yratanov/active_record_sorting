class User < ActiveRecord::Base
  include ActiveRecordSorting::Concern

  belongs_to :group
end
