class PostsController < ApplicationController
    def index
        @user = current_user
        @followees = current_user.followees
        @posts = Post.where(user_id: @followees).order('created_at DESC')
    end

    
    def new 
        @post = Post.new 
    end

    def create
        @post = current_user.posts.build(post_params)
        @post.author = current_user.name
        if @post.save
        redirect_to root_path
        else
            flash[:error] = "Failed to create post. Please check errors below."
            render :new
        end
    end

    def show
        @post = Post.find_by_id(params[:id])
    end

    def edit
        @post = Post.find_by_id(params[:id])
    end

    def update 
        @post = Post.find(params[:id])
        if @post.update(post_params)
            #redirect_to post_path(@post)
            redirect_to root_path
        else
            render :edit
        end
    end

    def destroy
        @post = Post.destroy(params[:id])

        redirect_to root_path, status: :see_other
    end


    private
    def post_params
        params.require(:post).permit(:title, :body, :image, :likes)
    end
end