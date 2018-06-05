class StaticPagesController < ApplicationController
    def home
        if logged_in?
            @post = current_author.posts.build
            @feed_items = current_author.feed.desc.paginate(page: params[:page]) 
            @catalog = Post.catalogs
        end
    end
    
end
