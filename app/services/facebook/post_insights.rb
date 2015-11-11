module Facebook
  class PostInsights
    def initialize(facebook_post_id)
      @facebook_post_id = facebook_post_id
    end

    def insights
      page_graph.get_connections(@facebook_post_id, 'insights')
    end

    private

    def page_graph
      @page_graph ||= Facebook::Page.new.page_graph
    end
  end
end
