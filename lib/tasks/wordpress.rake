namespace :wordpress do
  desc "Get all wordpress posts"
  task add_posts: :environment do
    Dsh::AddWordpressPosts.new.perform
  end

  desc "Update all wordpress posts with insights"
  task update_posts: :environment do
    WordpressPost.find_each do |post|
      Dsh::UpdateWordpressPost.new(post).perform
    end
  end

  desc "Update recent wordpress posts with insights"
  task update_recent_posts: :environment do
    WordpressPost.recent.each do |post|
      Dsh::UpdateWordpressPost.new(post).perform
    end
  end

  desc "Update earnings"
  task update_earnings: :environment do
    WordpressPost.find_each do |post|
      post.calculate_earnings
      post.save
    end
  end

end
