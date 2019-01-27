class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page]).per(15).recent
    @like_ranking = Post.where(id: Like.group(:post_id).order('count(post_id) desc').limit(15).pluck(:post_id))
    @genres = Genre.all
  end

  def like_ranking
    @posts = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(50).pluck(:post_id))
  end

  def genre
    @genre = Genre.find params[:id]
    @post = Post.where('genre_id = ?', params[:id]).order('created_at desc')
    #redirect_to '/genres/:id'
  end


  def show
    @user = User.find_by(id: @post.user_id)
    @like = current_user.likes.find_by(post_id: @post.id) if user_signed_in?
    @likes_count = Like.where(post_id: @post.id).count
    @genres = Genre.all
    @posts = Post.where(id: params[:genre_id]).order(created_at: :desc)
    @genres = @posts.genre
  end

  # GET /posts/new
  def new
    @post = Post.new
    @genres = Genre.all
  end

  # GET /posts/1/edit
  def edit
    @genres = Genre.all
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @genres = Genre.all
    if @post.save
      #make_picture
      redirect_to @post, notice: '投稿しました。投稿ありがとうございます。'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @genres = Genre.all
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :summary, :content, :user_id, :genre_id)
    end

    def correct_user
      if current_user.id != @post.user_id
         redirect_to posts_path, notice: '他のユーザーの投稿は編集できません。'
      end
    end
end
