class LikeController < ApplicationController
  
  def toggle
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
    
end
