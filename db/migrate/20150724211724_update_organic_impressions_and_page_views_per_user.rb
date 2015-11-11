class UpdateOrganicImpressionsAndPageViewsPerUser < ActiveRecord::Migration
  def change
    WordpressPost.all.each do |post|
      post.page_views_per_session = post.sessions > 0 ? (post.unique_page_views / post.sessions.to_f).round(2) : 0
      post.page_views_per_user = post.users > 0 ? (post.unique_page_views / post.users.to_f).round(2) : 0
      post.save
    end

    FacebookPost.all.each do |post|
      post.impressions_organic_unique = post.impressions_unique - post.impressions_paid_unique
      post.impressions_organic = post.impressions - post.impressions_paid
      post.save
    end
  end
end
