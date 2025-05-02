class ForumController < ApplicationController
  def forum
    @notifications = Notification.where(to_user: Current.user.email_address)
    @contacts1 = Contact.where(user1_email: Current.user.email_address).where(accepted: true)
    @contacts2 = Contact.where(user2_email: Current.user.email_address).where(accepted: true)

    msg = Conversation.all
    @headlines = Array.new

    msg.each do |m|
      if m.message_id == 0
        array = m.participants.split(",")
        array.each do |a|
          if a == Current.user.email_address
            @headlines.append(m)
          end
        end
      end
    end

  end

  def course_discussion
    @category = 0
    @threads = Post.all.where(category_id: 0).where(comment_id: 0)
    @topics = [["Economics", "Economics"], ["CompSci", "CompSci"], ["Maths", "Maths"], ["Chemistry", "Chemistry"], ["Rocket Science", "Rocket Science"], ["Biology", "Biology"], ["Chaos Theory", "Chaos Theory"]]

    @notifications = Notification.where(to_user: Current.user.email_address)
    @contacts1 = Contact.where(user1_email: Current.user.email_address).where(accepted: true)
    @contacts2 = Contact.where(user2_email: Current.user.email_address).where(accepted: true)

    msg = Conversation.all
    @headlines = Array.new

    msg.each do |m|
      if m.message_id == 0
        array = m.participants.split(",")
        array.each do |a|
          if a == Current.user.email_address
            @headlines.append(m)
          end
        end
      end
    end
  end

  def project_discussion
    @category = 1
    @threads = Post.all.where(category_id: 1).where(comment_id: 0)
    @topics = [["Economics Projects", "Economics Projects"], ["CS Projects", "CS Projects"], ["Maths Projects", "Maths Projects"]]

    @notifications = Notification.where(to_user: Current.user.email_address)
    @contacts1 = Contact.where(user1_email: Current.user.email_address).where(accepted: true)
    @contacts2 = Contact.where(user2_email: Current.user.email_address).where(accepted: true)

    msg = Conversation.all
    @headlines = Array.new

    msg.each do |m|
      if m.message_id == 0
        array = m.participants.split(",")
        array.each do |a|
          if a == Current.user.email_address
            @headlines.append(m)
          end
        end
      end
    end
  end

  def hobbies
    @category = 2
    @threads = Post.all.where(category_id: 2).where(comment_id: 0)
    @topics = [["Music", "Music"], ["Movies", "Movies"], ["Video Games", "Video Games"], ["Exercise", "Exercise"]]

    @notifications = Notification.where(to_user: Current.user.email_address)
    @contacts1 = Contact.where(user1_email: Current.user.email_address).where(accepted: true)
    @contacts2 = Contact.where(user2_email: Current.user.email_address).where(accepted: true)

    msg = Conversation.all
    @headlines = Array.new

    msg.each do |m|
      if m.message_id == 0
        array = m.participants.split(",")
        array.each do |a|
          if a == Current.user.email_address
            @headlines.append(m)
          end
        end
      end
    end
  end

  def search
    @searched = params[:query]
    @threads = Post.all.where(comment_id: 0)
    @search_result = @threads.select { |str| str.post_text.downcase.include?(@searched.downcase) }

    @notifications = Notification.where(to_user: Current.user.email_address)
    @contacts1 = Contact.where(user1_email: Current.user.email_address).where(accepted: true)
    @contacts2 = Contact.where(user2_email: Current.user.email_address).where(accepted: true)

    msg = Conversation.all
    @headlines = Array.new

    msg.each do |m|
      if m.message_id == 0
        array = m.participants.split(",")
        array.each do |a|
          if a == Current.user.email_address
            @headlines.append(m)
          end
        end
      end
    end
  end

  def thread
    @posts = Post.all.where(thread_id: params[:thread])

    @notifications = Notification.where(to_user: Current.user.email_address)
    @contacts1 = Contact.where(user1_email: Current.user.email_address).where(accepted: true)
    @contacts2 = Contact.where(user2_email: Current.user.email_address).where(accepted: true)

    msg = Conversation.all
    @headlines = Array.new

    msg.each do |m|
      if m.message_id == 0
        array = m.participants.split(",")
        array.each do |a|
          if a == Current.user.email_address
            @headlines.append(m)
          end
        end
      end
    end
  end

end