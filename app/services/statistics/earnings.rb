module Statistics
  class Earnings

    def initialize(user, start_date = Date.current.beginning_of_month.beginning_of_day, end_date = Date.current.end_of_day)
      @user = user
      @start_date = start_date
      @end_date = end_date
    end

    def posts_number
      @posts_number ||= wordpress_posts.count
    end

    def news_number
      @news_number ||= news.count
    end

    def lists_number
      @lists_number ||= lists.count
    end

    def news_earnings
      @news_earnings ||= news.sum(:earnings)
    end

    def lists_earnings
      @lists_earnings ||= lists.sum(:earnings)
    end

    def total_earnings
      @total_earnings ||= news_earnings + lists_earnings
    end

    private

    def wordpress_posts
      wordpress_posts ||= @user.wordpress_posts.where(created_time: @start_date..@end_date)
    end

    def news
      wordpress_posts.news
    end

    def lists
      wordpress_posts.lists
    end
  end
end
