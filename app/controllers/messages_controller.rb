class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_conversation
    users_to_add = params[:participants].as_json

    i = 0
    participants = ""
    participants.concat(Current.user.email_address)
    participants.concat(",")
    if users_to_add.size > 1
      while i < users_to_add.size do
        participants.concat(users_to_add["#{i}"])
        participants.concat(",")
        i = i + 1
      end
      @c = Conversation.new(participants: participants, chat_id: (Conversation.maximum("chat_id") + 1), message_id: 0 , chat_name: params[:chatName], sender_email: Current.user.email_address, message: params[:message])
      @c.save
    end

  end

  def send_message
    msg = Conversation.new(participants: Conversation.where(chat_id: params[:chat_id]).first.participants, chat_id: params[:chat_id], message_id: (Conversation.where(chat_id: params[:chat_id]).last.message_id + 1), chat_name: Conversation.where(chat_id: params[:chat_id]).first.chat_name, sender_email: Current.user.email_address, message: params[:message])
    msg.save

    prtcpntsGet = Conversation.where(chat_id: params[:chat_id]).first.participants
    prtcpntsArray = Array.new

    array = prtcpntsGet.split(",")
    array.each do |a|
      if a != Current.user.email_address
          prtcpntsArray.append(a)
      end
    end

    prtcpntsArray.each do |p|
      notification = Notification.new(to_user: p, message: "You got a new message in chatroom: " + Conversation.where(chat_id: params[:chat_id]).first.chat_name)
      notification.save
    end

  end

  def get_chat
    @messages = Conversation.where(chat_id: params[:chat_id])
    respond_to do |format|
      format.json {render json: @messages.to_json}
    end
  end

end
