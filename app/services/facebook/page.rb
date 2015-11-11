module Facebook
  class Page
    PAGE_ID = '1578798579015610' # DailySuperheroes

    def initialize(since = nil)
      @since = since
    end

    def posts
      page_graph.get_connections("me", "posts",
        {
          limit: 250,
          fields: ['id', 'picture', 'link', 'name', 'admin_creator', 'created_time'],
          since: @since
        }
      )
    end

    def page_graph
      @page_graph ||= Koala::Facebook::API.new(page_token)
    end

    private

    def user
      @user ||= User.admins.first
    end

    def user_graph
      @user_graph ||= Koala::Facebook::API.new(user.access_token)
    end

    def page_token
      @page_token ||= user_graph.get_page_access_token(PAGE_ID)
    end
  end
end
