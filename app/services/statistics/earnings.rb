module Statistics
  class Earnings

    def initialize(user, start_date = Date.current.beginning_of_month.beginning_of_day, end_date = Date.current.end_of_day)
      @user = user
      @start_date = start_date
      @end_date = end_date
    end

    def earnings
      ((facebook_organic_impressions / 1000.to_f) * multiplier).round(2)
    end

    def average_earnings_per_wordpress_post
      wordpress_posts_number > 0 ? (earnings / wordpress_posts_number).round(2) : 0
    end

    def facebook_posts_number
      facebook_posts.count
    end

    def wordpress_posts_number
      wordpress_posts.count
    end

    private

    def facebook_posts
      facebook_posts ||= @user.facebook_posts.where(created_time: @start_date..@end_date)
    end

    def wordpress_posts
      wordpress_posts ||= @user.wordpress_posts.where(created_time: @start_date..@end_date)
    end

    def facebook_organic_impressions
      current_month? ? @user.current_facebook_stats.impressions_organic : @user.previous_facebook_stats.impressions_organic
    end

    def page_views_per_user
      current_month? ? @user.current_wordpress_stats.page_views_per_user : @user.previous_wordpress_stats.page_views_per_user
    end

    def current_month?
      Date.current.month == @start_date.month
    end

    def multiplier
      return 0.2 if page_views_per_user < 2
      return 0.3 if page_views_per_user < 2.5
      return 0.4 if page_views_per_user < 3
      return 0.5 if page_views_per_user < 3.5
      return 0.6 if page_views_per_user < 4
      return 0.7 if page_views_per_user < 4.5
      return 0.8 if page_views_per_user < 5
      return 0.9 if page_views_per_user < 5.5
      return 1.0 if page_views_per_user < 6
      return 1.1 if page_views_per_user < 6.5
      return 1.2 if page_views_per_user < 7
      return 1.3 if page_views_per_user < 7.5
      return 1.4 if page_views_per_user < 8
      return 1.5 if page_views_per_user < 8.5
      return 1.6 if page_views_per_user < 9
      return 1.7 if page_views_per_user < 9.5
      return 1.8 if page_views_per_user < 10
      return 1.9 if page_views_per_user < 10.5
      return 2.0 if page_views_per_user < 11
      return 2.1 if page_views_per_user < 11.5
      return 2.2 if page_views_per_user < 12
      return 2.3 if page_views_per_user < 12.5
      return 2.4 if page_views_per_user < 13
      return 2.5 if page_views_per_user < 13.5
    end
  end
end
