module Dsh
  class EarningsCalculator
    def initialize(post, user)
      @post = post
      @user = user
    end
    
    def earnings
      if @post.list?
        list_price
      else
        @user.price_per_news
      end
    end

    private

    def list_price
      if base?
        @user.price_per_list
      elsif above_base?
        above_base_price
      else
        below_base_price
      end
    end

    def below_base_price
      @user.price_per_list - (@user.base_page_views_per_list - @post.page_views_per_user.to_i) * @user.bellow_base_price 
    end

    def above_base_price
      @user.price_per_list + (@post.page_views_per_user.to_i - @user.base_page_views_per_list) * @user.above_base_price
    end

    def above_base?
      @post.page_views_per_user.to_i > @user.base_page_views_per_list
    end

    def base?
      @post.page_views_per_user.to_i == @user.base_page_views_per_list
    end
  end
end
