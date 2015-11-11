class PopulateWordpressIdForFacebookPost < ActiveRecord::Migration
  def change
    FacebookPost.all.each do |facebook_post|
      if facebook_post.link.present?
        facebook_post.wordpress_id = facebook_post.link.split("/").last
        facebook_post.save
      end
    end   
  end
end
