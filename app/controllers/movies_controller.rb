class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index		
		
		@class_title = nil
		@class_date = nil

		order = session[:order]
		if order == :title_asc
			@movies = Movie.order('title asc').all
			@class_title = :hilite
			session[:order] = :title_desc
		elsif order == :title_desc
			@movies = Movie.order('title desc').all
			@class_title = :hilite
			session[:order] = nil
		else
	    @movies = Movie.all
			session[:order] = :title_asc
		end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
