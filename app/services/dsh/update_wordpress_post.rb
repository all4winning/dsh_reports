module Dsh
  class UpdateWordpressPost
    def initialize(post)
      @post = post
    end

    def perform
      analytics_searcher.wordpress_post_insights
      update_post_insights
    end

    private

    def update_post_insights
      @post.sessions = analytics_searcher.sessions
      @post.page_views = analytics_searcher.page_views
      @post.unique_page_views = analytics_searcher.unique_page_views
      @post.average_time_on_page = analytics_searcher.average_time_on_page
      @post.users = analytics_searcher.users
      @post.page_views_per_session = analytics_searcher.page_views_per_session
      @post.page_views_per_user = analytics_searcher.page_views_per_user
      @post.list = list?
      @post.calculate_earnings
      @post.save
      puts "Updated wordpress post with id: " + @post.wordpress_id.to_s
    end

    def analytics_searcher
      @analytics_searcher ||= Dsh::AnalyticsSearcher.new(post: @post)
    end

    def list?
      analytics_searcher.page_views_per_user >= 3
    end
  end
end
