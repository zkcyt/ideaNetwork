class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find params[:id]
    @posts = Post.where(id: params[:genre_id]).order(created_at: :desc)
    #@post = Post.where('genre_id = ?', params[:id]).order('created_at desc')
    #redirect_to '/genres/:id'
  end

  def add
    @genre = Genre.new
    if request.post? then
      @genre = Genre.create(genre_params)
      #@genre.save
      redirect_to '/genres', data: {"turbolinks" => false}
    end
  end

  def edit
    @genre = Genre.find params[:id]
    if request.patch? then
      @genre.update genre_params
      redirect_to '/genres', data: {"turbolinks" => false}
    end
  end

  def destroy
    @genre.destroy
    respond_to do |format|
      format.html { redirect_to genres_url, notice: 'Genre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :memo, :post_id)
  end
end
