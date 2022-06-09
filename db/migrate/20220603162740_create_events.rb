class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      # Not added unique index as I'm taking assumption that multiple events can have same name
      t.string :name, null: false
      t.string :organizer
      t.datetime :start_date # Not added null false constraint because some events have no date
      t.datetime :end_date # Not added null false constraint because some events have no date
      t.string :type, null: false
      t.timestamps
    end
  end
end
