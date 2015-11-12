module Dsh
  class AnalyticsSearcher
    def initialize(start_date:, end_date:, post:)
      @start_date = start_date
      @end_date = end_date
      @post = post
    end

    def wordpress_post_insights
      @wordpress_post_insights ||= analytics.query(@post.wordpress_id, @start_date, @end_date)
    end

    def analytics
      @analytics ||= Analytics.new
    end

    def sessions
      wordpress_post_insights.present? ? wordpress_post_insights[0] : 0
    end

    def page_views
      wordpress_post_insights.present? ? wordpress_post_insights[1] : 0
    end

    def unique_page_views
      wordpress_post_insights.present? ? wordpress_post_insights[2] : 0
    end

    def page_views_per_session
      wordpress_post_insights.present? ? wordpress_post_insights[3].to_f.round(2) : 0
    end

    def average_time_on_page
      wordpress_post_insights.present? ? wordpress_post_insights[4].to_f.round(2) : 0
    end

    def users
      wordpress_post_insights.present? ? wordpress_post_insights[5] : 0
    end
  end
end
