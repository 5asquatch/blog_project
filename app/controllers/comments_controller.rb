class CommentsController < ApplicationController
   before_action :set_post

   def index
      @comments = Comment.includes(:post).order(created_at: :desc)
   end

   def set_post
      @post = Post.find(params[:post_id])
   end

   def create
      @comment = @post.comments.create(comment_params)
      @comment.user_id = current_user.id
      @comment.author = current_user.name
      redirect_to post_path(@post) if @comment.save
   end

   def edit
      @comment = @post.comments.find(params[:id])
   end

   def update 
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
          redirect_to post_path(@post)
      else
          render :edit
      end
  end


   def destroy
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to post_path(@post) if @comment.delete
   end

   def comment_params
      params.require(:comment).permit(:body, :author)
   end
     
end