class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.string :details
      t.string :institution

      t.timestamps
    end
  end
end
