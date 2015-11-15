namespace :facebook do
  desc "Get all facebook posts"
  task add_posts: :environment do
    Dsh::AddFacebookPosts.new.perform
  end

  desc "Get recent facebook posts"
  task add_recent_posts: :environment do
    Dsh::AddFacebookPosts.new((Time.now - 1.day).to_i).perform
  end

  desc "Update all facebook posts with insights"
  task update_posts: :environment do
    FacebookPost.find_each do |post|
      Dsh::UpdateFacebookPost.new(post).perform
    end
  end

  desc "Update recent facebook posts with insights"
  task update_recent_posts: :environment do
    FacebookPost.recent.each do |post|
      Dsh::UpdateFacebookPost.new(post).perform
    end
  end

end
