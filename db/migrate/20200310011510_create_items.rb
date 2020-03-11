class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :title
      t.string :category
      t.text :body
      t.string :repletion_image

      t.timestamps
    end
  end
end
