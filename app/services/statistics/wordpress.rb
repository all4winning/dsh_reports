module Statistics
  class Wordpress

    def initialize(user, start_date = Date.current.beginning_of_month.beginning_of_day, end_date = Date.current.end_of_day)
      @user = user
      @start_date = start_date
      @end_date = end_date
    end

    def sessions
      wordpress_posts.sum(:sessions)
    end

    def users
      wordpress_posts.sum(:users)
    end

    def page_views
      wordpress_posts.sum(:page_views)
    end

    def unique_page_views
      wordpress_posts.sum(:unique_page_views)
    end

    def page_views_per_session
      sessions > 0 ? (unique_page_views / sessions.to_f).round(2) : 0
    end

    def page_views_per_user
      users > 0 ? (unique_page_views / users.to_f).round(2) : 0
    end

    def average_time_on_page
      wordpress_posts.count > 0 ? wordpress_posts.sum(:average_time_on_page) / wordpress_posts.count : 0
    end

    private

    def wordpress_posts
      if @user.admin?
        @wordpress_posts ||= WordpressPost.where(created_time: @start_date..@end_date)
      else
        @wordpress_posts ||= @user.wordpress_posts.where(created_time: @start_date..@end_date)
      end
    end
  end
end
