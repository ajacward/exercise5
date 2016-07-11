class Movie < ActiveRecord::Base

  def Movie.find_movies_by_director director
    self.where(director: director).to_a
  end

end
