class PostsController < ApplicationController
  add_flash_types :info, :error, :success
  def new
    @threads = Post.all.where(comment_id: 0)
  end

  def create
    if params[:post][:type] == "thread"
      if == Post.last.thread_id.nil?
        @post = Post.new(topic_id: params[:post][:topic_id], post_text: params[:post][:post_text], comment_id: 0, user_email: Current.user.email_address, text: params[:post][:text], created_at: DateTime.now, thread_id: 1, category_id: params[:post][:category_id])
      else
        @post = Post.new(topic_id: params[:post][:topic_id], post_text: params[:post][:post_text], comment_id: 0, user_email: Current.user.email_address, text: params[:post][:text], created_at: DateTime.now, thread_id: (Post.last.thread_id + 1), category_id: params[:post][:category_id])
      end
      @post.save
    elsif params[:post][:type] == "comment"
      @post = Post.new(topic_id: params[:post][:topic_id], post_text: params[:post][:post_text], comment_id: (Post.where(thread_id: params[:post][:thread_id]).last.comment_id + 1), user_email: Current.user.email_address, text: params[:post][:text], created_at: DateTime.now, thread_id: params[:post][:thread_id], category_id: params[:post][:category_id])
      @post.save
    end
    redirect_to request.referrer
  end



end
