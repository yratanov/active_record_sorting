ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :name
    t.integer :age
    t.integer :group_id

    t.timestamps
  end

  create_table :groups, :force => true do |t|
    t.string :name

    t.timestamps
  end

end
