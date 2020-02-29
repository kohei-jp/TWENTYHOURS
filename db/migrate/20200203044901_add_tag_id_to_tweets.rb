class AddTagIdToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :tag_id, :integer
  end
end
