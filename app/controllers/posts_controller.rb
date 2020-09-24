class PostsController < ApplicationController
  before_action :set_target_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :mypage]
  before_action :check_guest, only: [:new, :create, :update, :destroy, :mypage]
  before_action :set_search

  def index
    @posts = Post.all.order(updated_at: "DESC").includes(:room).limit(10)
  end

  def new
    @post = Post.new
    @post.build_room
  end

  def mypage
    @posts = current_user.posts.page(params[:page])
    @messages = Message.all.includes(:room).where(user_id:current_user.id).order(updated_at: "DESC")
    @ary = []
  end

  def all_content
    @posts = Post.page(params[:page]).order(updated_at: "DESC").includes(:room)
  end

  def search_posts
    @q = Post.ransack(params[:q])
    grouping_hash = params[:q][:app_or_chess_or_time_or_all_tag_cont].split(",").reduce({}){|hash, word| hash.merge(word => { app_or_chess_or_time_or_all_tag_cont: word })}
    @posts = Post.ransack({ combinator: 'and', groupings: grouping_hash }).result.includes(:room).order(updated_at: "DESC").page(params[:page])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "名前が投稿しました。"
      redirect_to("/")
    else
      render("posts/new")
    end
  end

  def show
    @room = @post.room
    @url = request.url
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "更新しました。"
      redirect_to("/")
    else
      render("posts/edit")
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "「#{@post.room.name}」の投稿が削除されました。"
      redirect_to("/")
    else
      render("posts/edit")
    end
  end

  private


  def post_params
    params.require(:post).permit(:content, :app, :time, :chess, :all_tag, room_attributes:[:id, :name])
  end

  def set_target_post
    @post = Post.find(params[:id])
  end

end
