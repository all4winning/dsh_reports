module Wordpress
  class Posts
    def posts
      query_string = "SELECT id, post_author, post_date, post_title, post_name FROM wp_posts where post_status = 'publish'"

      @posts ||= client.query(query_string)
    end

    private

    def client
      @client ||= Mysql2::Client.new(host: ENV["WORDPRESS_HOST"], port: ENV["WORDPRESS_PORT"], username: ENV["WORDPRESS_USERNAME"], database: ENV["WORDPRESS_DATABASE"], password: ENV["WORDPRESS_PASSWORD"])
    end
  end
end
