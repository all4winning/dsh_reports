module Dsh
  class UpdateWordpressPost
    def initialize(post)
      @post = post
    end

    def perform
      update_post_insights if wordpress_post_insights.present?
    end

    private

    def update_post_insights
      @post.sessions = sessions
      @post.page_views = page_views
      @post.unique_page_views = unique_page_views
      @post.average_time_on_page = average_time_on_page
      @post.users = users
      @post.page_views_per_session = @post.sessions > 0 ? (@post.unique_page_views / @post.sessions.to_f).round(2) : 0
      @post.page_views_per_user = @post.users > 0 ? (@post.unique_page_views / @post.users.to_f).round(2) : 0
      @post.save
      puts "Updated wordpress post with id: " + @post.wordpress_id.to_s
    end

    def wordpress_post_insights
      @wordpress_post_insights ||= analytics.query(@post.wordpress_id)
    end

    def analytics
      @analytics ||= Analytics.new
    end

    def sessions
      wordpress_post_insights[0]
    end

    def page_views
      wordpress_post_insights[1]
    end

    def unique_page_views
      wordpress_post_insights[2]
    end

    def page_views_per_session
      wordpress_post_insights[3]
    end

    def average_time_on_page
      wordpress_post_insights[4]
    end

    def users
      wordpress_post_insights[5]
    end
  end
end
