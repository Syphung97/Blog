class Supports::Author
  attr_reader :author, :current_author

  def initialize arg = {}
    @author = arg[:author]
    @current_author = arg[:current_author]
  end

  def new_relation
    @new_relation = current_author.active_relationships.build
  end

  def current_relation
    @current_relation =
      current_author.active_relationships.find_by followed_id: author.id
  end
end
