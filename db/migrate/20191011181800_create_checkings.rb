class CreateCheckings < ActiveRecord::Migration[6.0]
  def change
    create_table :checkings do |t|
      t.datetime :happend_at
      t.string :check_type
      t.bigint :user_id

      t.timestamps
    end
  end
end
