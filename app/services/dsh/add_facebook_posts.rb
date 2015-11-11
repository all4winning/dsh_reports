module Dsh
  class AddFacebookPosts
    def initialize(since = nil)
      @since = since
    end

    def perform
      facebook_posts

      while @facebook_posts.present?
        save_facebook_posts(@facebook_posts)
        @facebook_posts = @facebook_posts.next_page
      end
    end

    private

    def save_facebook_posts(posts)
      posts.each do |post|
        save_facebook_post(post)
      end
    end

    def save_facebook_post(facebook_post)
      post = FacebookPost.find_by_facebook_id(facebook_post["id"])
      return if post.present?

      post = FacebookPost.new
      post.facebook_id = facebook_post["id"]
      post.picture_link = facebook_post["picture"]
      post.link = facebook_post["link"]
      post.name = facebook_post["name"]
      post.created_time = facebook_post["created_time"].to_datetime
      post.facebook_user_id = facebook_post["admin_creator"]["id"]
      post.wordpress_id = facebook_post["link"].split("/").last
      post.save
      puts "Saved facebook post with id: " + facebook_post["id"]
    end

    def facebook_posts
      @facebook_posts ||= Facebook::Page.new(@since).posts
    end
  end
end
