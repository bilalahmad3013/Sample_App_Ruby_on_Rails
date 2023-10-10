require 'pry'
class MicropostsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :toggle_like
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @micropost = current_user.microposts.build(micropost_params)
        @micropost.image.attach(params[:micropost][:image])
        if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
        else
        @feed_items = current_user.feed.paginate(page: params[:page])
        render 'static_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end

    def toggle_like
        micropost = Micropost.find(params[:id])
        like = current_user.likes.find_by(micropost: micropost)
        liked = false
      
        if like
          like.destroy
        else
          current_user.likes.create(micropost: micropost, liked: true)
          liked = true
        end
      
        likes_count = Like.where(micropost_id: micropost.id).count
      
        render json: { liked: liked, likes_count: likes_count }
    end
      
    

    
    private
    def micropost_params
    params.require(:micropost).permit(:content)
    end

    def micropost_params
        params.require(:micropost).permit(:content, :image)
    end

    def correct_user
        @micropost = current_user.microposts.find_by(id: params[:id])
        redirect_to root_url if @micropost.nil?
    end

    end