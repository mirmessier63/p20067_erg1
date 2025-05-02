class UsersController < ApplicationController
  def users
    # Contact.destroy_all
    @users = User.all
    @friends_s = Contact.all.where(user1_email: Current.user.email_address).where(accepted: true)
    @friends_r = Contact.all.where(user2_email: Current.user.email_address).where(accepted: true)
    @f_requests = Contact.all.where(user2_email: Current.user.email_address).where(accepted: false)

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

  def friend_request
    @contact = Contact.new(user1_email: Current.user.email_address, user2_email: params[:req], accepted: false)
    @contact.save
    redirect_to request.referrer
  end

  def accept
    @request = Contact.where(user1_email: params[:req]).where(user2_email: Current.user.email_address)
    @a = @request.update(accepted: true)
    redirect_to request.referrer
  end

  def reject
    @request = Contact.where(user1_email: params[:req]).where(user2_email: Current.user.email_address)
    @request.destroy(@request.ids)
    redirect_to request.referrer
  end

end