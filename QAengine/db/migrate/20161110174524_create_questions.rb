class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :upvotes
      t.integer :downvotes
      t.string :tags
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :questions, [:user_id, :created_at]
  end
end
