require 'rails_helper'

describe MoviesController do
  describe 'finding movies by same director' do
    before :each do
      @movie_id = 10
      @found = [double('a movie'), double('another one')]
      @fake_movie = double('double', :director => 'fake director')
      @movie = [double('movie1')]
    end

    it 'should render movies_with_same_director view' do
      expect(Movie).to receive(:find).and_return(@fake_movie)
      expect(Movie).to receive(:find_movies_by_director).and_return(@found)

      get :movies_with_same_director, {:id => @movie_id}
      expect(response).to render_template 'movies_with_same_director'
    end

    it 'should call Model method to get movies with same director' do
      expect(Movie).to receive(:find).with(@movie_id.to_s).and_return(@fake_movie)
      expect(Movie).to receive(:find_movies_by_director).with(@fake_movie.director).and_return(@found)

      get :movies_with_same_director, {:id => @movie_id}
    end

    it 'should make found movies available to the view' do
      expect(Movie).to receive(:find).and_return(@fake_movie)
      expect(Movie).to receive(:find_movies_by_director).with(@fake_movie.director).and_return(@found)

      get :movies_with_same_director, {:id => @movie_id}

      expect(assigns(:movies)).to eq(@found)
    end

    it 'should return to home page, if no movies found' do
      empty_director =  double('movie', :director => '').as_null_object
      expect(Movie).to receive(:find).and_return(empty_director)
			
      get :movies_with_same_director, {:id => @movie_id}
      expect(response).to redirect_to(movies_path)						
    end
  end
end
