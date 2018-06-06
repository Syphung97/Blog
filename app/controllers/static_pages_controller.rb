class StaticPagesController < ApplicationController
    def home
        if logged_in?
            @post = current_author.posts.build
            @feed_items = current_author.feed.desc.paginate(page: params[:page]) 
            @catalog = Post.catalogs
            @feed_items_1 = current_author.not_feed.desc.paginate(page: params[:page]) 
        end
        @new_feed = Post.paginate(page: params[:page]).desc
    end
    
end
