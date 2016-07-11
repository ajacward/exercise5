class MoviesController < ApplicationController
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sort] == "title"
      @title_flag = "hilite"
      @date_flag = false
      @movies = Movie.all.order(:title)
    elsif params[:sort] == "date"
      @title_flag = false
      @date_flag = "hilite"
      @movies = Movie.all.order(:release_date)
    else   
      @title_flag = @date_flag = false
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def movies_with_same_director
    movie = Movie.find(params[:id])
    director = movie.director
    
    if director == nil or director == ""
      flash[:notice] = "'#{movie.title}' doesn't have a director recorded."
      redirect_to movies_path
    else
      @movies = Movie.find_movies_by_director(director)
      flash[:notice] = "#{@movies.size} movies share the same director"
    end
  end  
end
