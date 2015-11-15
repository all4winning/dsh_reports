class UpdateListValueFromWordpressPost < ActiveRecord::Migration
  def up
    WordpressPost.find_each do |post|
      if post.page_views_per_user >= 3
        post.list = true
        post.save
      end
    end      
  end
end
