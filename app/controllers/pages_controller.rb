class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def home
    redirect_to new_session_path unless authenticated?
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

    @notifications = Notification.where(to_user: Current.user.email_address)

  end

  def delete_notification
    Notification.destroy(params[:n_id])
    redirect_to request.referrer
  end
end