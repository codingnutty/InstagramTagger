class CreateInstaPosts < ActiveRecord::Migration
  def change
    create_table :insta_posts do |t|
      t.string :ig_username
      t.string :tag_time
      t.string :content_type
      t.string :ig_link
      t.string :image_url
      t.string :video_url
      t.text :description
      t.references :collection, index: true

      t.timestamps null: false
    end
  end
end
