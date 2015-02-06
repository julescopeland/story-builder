class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.text :text
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
