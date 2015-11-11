module Dsh
  class UpdateFacebookPost
    def initialize(post)
      @post = post
    end

    def perform
      update_post_insights
    end

    private

    def update_post_insights
      @post.impressions = metric_value('post_impressions')
      @post.impressions_unique = metric_value('post_impressions_unique')
      @post.impressions_paid_unique = metric_value('post_impressions_paid_unique')
      @post.impressions_paid = metric_value('post_impressions_paid')
      @post.impressions_organic_unique = @post.impressions_unique - @post.impressions_paid_unique
      @post.impressions_organic = @post.impressions - @post.impressions_paid
      @post.impressions_viral_unique = metric_value('post_impressions_viral_unique')
      @post.impressions_viral = metric_value('post_impressions_viral')
      @post.impressions_fan_unique = metric_value('post_impressions_fan_unique')
      @post.impressions_fan = metric_value('post_impressions_fan')
      @post.impressions_fan_paid_unique = metric_value('post_impressions_fan_paid_unique')
      @post.impressions_fan_paid = metric_value('post_impressions_fan_paid')
      @post.consumptions = metric_value('post_consumptions')
      @post.consumptions_unique = metric_value('post_consumptions_unique')
      @post.negative_feedback = metric_value('post_negative_feedback')
      @post.negative_feedback_unique = metric_value('post_negative_feedback_unique')
      @post.engaged_fan = metric_value('post_engaged_fan')
      @post.fan_reach = metric_value('post_fan_reach')
      @post.storytellers = metric_value('post_storytellers')
      @post.save
      puts "Updated facebook post with id: " + @post.facebook_id
    end

    def facebook_post_insights
      @facebook_post_insights ||= Facebook::PostInsights.new(@post.facebook_id).insights
    end

    def metric_value(metric_name)
      facebook_post_insights.select { |metric| metric["name"] == metric_name }.first["values"].first["value"]
    end
  end
end
