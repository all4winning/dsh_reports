module Statistics
  class Facebook

    def initialize(user, start_date = Date.current.beginning_of_month.beginning_of_day, end_date = Date.current.end_of_day)
      @user = user
      @start_date = start_date
      @end_date = end_date
    end

    def impressions
      facebook_posts.sum(:impressions_unique)
    end

    def clicks
      facebook_posts.sum(:consumptions_unique)
    end

    def impressions_organic
      facebook_posts.sum(:impressions_organic_unique)
    end

    def impressions_paid
      facebook_posts.sum(:impressions_paid_unique)
    end

    private

    def facebook_posts
      if @user.admin?
        @facebook_posts ||= FacebookPost.where(created_time: @start_date..@end_date)
      else
        @facebook_posts ||= @user.facebook_posts.where(created_time: @start_date..@end_date)
      end
    end
  end
end
