module Dsh
  class AddWordpressPosts
    def perform
      wordpress_posts.each do |wordpress_post|
        save_wordpress_post(wordpress_post)
      end
    end

    private

    def save_wordpress_post(wordpress_post)
      post = WordpressPost.find_by_wordpress_id(wordpress_post["id"])
      return if post.present?

      post = WordpressPost.new
      post.wordpress_id = wordpress_post["id"]
      post.title = wordpress_post["post_title"]
      post.name = wordpress_post["post_name"]
      post.created_time = wordpress_post["post_date"].to_datetime
      post.wordpress_user_id = wordpress_post["post_author"]
      post.save
      puts "Saved wordpress post with id: " + wordpress_post["id"].to_s
    end

    def wordpress_posts
      @wordpress_posts ||= Wordpress::Posts.new.posts
    end
  end
end
