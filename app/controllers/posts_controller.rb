class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :start_at, :end_at, :is_all_day, :memo))
    if @post.save
      flash[:notice_success] = "スケジュールを登録しました"
      redirect_to :posts
    else
      flash[:notice_failure] = "スケジュールを登録できませんでした"
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:title, :start_at, :end_at, :is_all_day, :memo))
      flash[:notice_success] = "スケジュールを更新しました"
      redirect_to :posts
    else
      flash[:notice_failure] = "スケジュールを更新できませんでした"
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice_delete] = "スケジュールを削除しました"
    redirect_to :posts, status: :see_other
  end
end
