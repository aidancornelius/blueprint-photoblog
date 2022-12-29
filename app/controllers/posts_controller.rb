class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.where(published: true).order(published_at: :desc).page params[:page]
    @posts_drafts = Post.all.where(published: false).order(published_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    if User.find(@post.user_id)
      @publisher = User.find(@post.user_id)
    else
      @publisher = null
    end 
  end

  # GET /posts/new
  def new
    @post = Post.new
    @secrandom = SecureRandom.random_number(10000000)
    @randwords = Spicy::Proton.pair
  end

  # GET /posts/1/edit
  def edit
    @secrandom = @post.post_identifier || SecureRandom.random_number(10000000)
    @randwords = @post.slug || Spicy::Proton.pair
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if params[:id]
       @post = Post.find(params[:id])
     elsif params[:slug]
       @post = Post.find_by_slug(params[:slug])
     end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:slug, :post_identifier, :title, :published_at, :published, :user_id, :image, :image_description, :body)
    end
end
