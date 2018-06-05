class RelationshipsController < ApplicationController
  before_action :logged_in_author
  after_action :ajax
  attr_reader :author

  def create
    @author = Author.find params[:followed_id]
    current_author.follow author
    @current_relation =
      current_author.active_relationships.find_by followed_id: author.id
  end

  def destroy
    @author = Relationship.find(params[:id]).followed
    current_author.unfollow author
    @new_relation = current_author.active_relationships.build
  end

  private

  def ajax
    respond_to do |format|
      format.html{redirect_to author}
      format.js
    end
  end
end
